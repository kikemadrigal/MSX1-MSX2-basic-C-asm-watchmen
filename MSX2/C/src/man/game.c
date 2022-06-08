
#pragma once
#include "fusion-c/header/msx_fusion.h"
//Para la función de setSpritePatter y SC5ColorSprite
#include "fusion-c/header/vdp_sprites.h"
#include "fusion-c/header/pt3replayer.h"
#include "fusion-c/header/ayfx_player.h"
#include "src/man/entity.c"
#include "src/sys/physics.c"
#include "src/sys/render.c"
#include "src/sys/collider.c"
#include "src/sys/ai.c"
#include "src/man/files.c"
#include "src/man/sprites.c"
#include "src/man/game_coordenates.c"

void man_game_init();
void man_game_play();
void man_game_update();
void man_game_pintarMapa();
void man_game_showBuffer();
void man_game_copiarSpritesVRAM();
void man_game_cargar_buffer_musica();
void man_game_cargar_buffer_efectos_sonido();
void man_game_reproducir_musica_y_efectos();
void man_game_reproducir_efecto_sonido(char effect);


void wait();
void debug();
void pintar_HUD();
//Efectos
#define SONG_EFFECT_TAM 1207
unsigned char songEffectsBuffer[SONG_EFFECT_TAM]; 
char fileNameSongEffects[]={"effects.afb"};
FCB TFileEffects; 

//Music
#define SONG_BUFFER_TAM 264
unsigned char songBuffer[SONG_BUFFER_TAM];  
char fileNameSong[]={"song1.pt3"};
FCB TFileMusic;




TEntity* player;
char actual_world;
char world_change;
char enabled_world_change;
char world_money;
unsigned int time;
unsigned int hours,minutes,secunds;
unsigned int memory_space;
unsigned int destiny_x_door;
unsigned int destiny_y_door;
unsigned int destiny_x_phone;
unsigned int destiny_y_phone; 

TEntity* array_enemies;
TEntity* array_objects;

int resultado;
void man_game_init(){
    //Inicializamos la pantalla en screen 5
    sys_render_init();
    //Cargamos la imagen de carga del archivo a la RAM
    //char *image_loader_name[]={"LOADER.S05"};
    load_file_into_buffer_with_structure("LOADER.S05");
    //Pasamos los datos de la RAM a la VRAM page 0
    HMMC(&buffer[0], 0,0,256,212 ); 
    //memset(buffer,0,sizeof(buffer));
    //El juego solo tendrá un archivo de tileset con todos los tiles
    load_file_into_buffer("tileset.s05");
    //Pasamos todos los tileset a la page 1, fijate:
    // 1. que hemos puesto en inicio y: 256.
    // 2. Hemos utilizado LMMC que nos permite introducir la transparencia
    HMMC(&buffer[0], 0,256,256,212); 
    //Cargamos los sprites
    load_file_into_buffer("sprites.bin");
    //Los pasamos a la VRAM
    man_game_copiarSpritesVRAM();

    //Cargamos los efectos de sonido  
    InitPSG(); 
    InitFX();
    man_game_cargar_buffer_efectos_sonido();
    //Cargamos la música
    man_game_cargar_buffer_musica();
    //load_file_into_buffer_with_structure("song1.pt3");
    PT3Init (songBuffer+99, 0);
    //incializamos el cronómetro
    SetRealTimer(0);
    //Le quitamos el sonido a las pulsaciones	
    KeySound(0);
    //Ponemos que el 1 mundo sea el 0
    actual_world=0;
    //Le ponemos que aplique que el mapa ha cambiado para que ponga
    // los objetos, enemigos y la posición del player del mundo correspondiente
    // Esto se aplica en el método man_game_update
    world_change=1;    

    //creamos al player
    player=sys_entity_create_player();
    PutText(0,0, "Eres un vigilante y como siempre estas durmiendo te han robado.",0);
    PutText(0,16, "Recoge las monedas que han ido perdiendo y llama a la policia, depues pasa de vivel.",0);
    PutText(20,180, "Press any key to continue",0);
    WaitKey();
}

void man_game_play(){
    do{
        //Game
        man_game_update();
        //Musica y efectos
        man_game_reproducir_musica_y_efectos();
        //Player
        sys_physics_update(player);
        sys_render_update(player);
        //Enemigos
        for (char i=0;i<sys_entity_get_num_enemies();++i){
            TEntity *enemy=&array_enemies[i];
            //Le aplicamos un comportamiento a los enemigos según el tipo de enemigo que sea
            sys_ai_update(enemy);
            sys_render_update(enemy);
            if (sys_collider_entity1_collider_entity(player, enemy)){
                man_game_reproducir_efecto_sonido(2);
                player->lives-=1;
                pintar_HUD();
            }
        }
        //Objetos
        for (char i=0;i<sys_entity_get_num_objects();++i){
            TEntity *object=&array_objects[i];
            sys_render_update(object);
            //Colisión de objetos con player
            if (sys_collider_entity1_collider_entity(player, object)){
                man_game_reproducir_efecto_sonido(5);
                player->points+=10;
                world_money-=1;
                sys_entity_erase_object(i);
                pintar_HUD();
            }
            
        }




        if (sys_entity_get_num_objects()==0){
            //Esto es el parapdeo del teléfono que indica que hay que cogerlo
            //HMMM(posicion_x_en_tilset, posicion_y_en_tileset, posicion_x_n_escenario,posicion_y_n_escenario,ancho_a_copiar,alto_a_copiar)
            if (time % 3==0 && enabled_world_change==0)HMMM(0,256+(4*8),destiny_x_phone,destiny_y_phone,16,16);
            else HMMM(8*2,256+(4*8),destiny_x_phone,destiny_y_phone,16,16);
            if (sys_collider_get_tile_array(player)==tile_phone1 || sys_collider_get_tile_array(player)==tile_phone2){
                enabled_world_change=1;
            }
            if (enabled_world_change==1){
                //Pintamos la puerta abierta
                HMMM(6*8,256+(3*8),destiny_x_door,destiny_y_door,16,24);
                //Si el player colisiona con la puerta aumentamos el nuvel
                if (sys_collider_get_tile_array(player)==tile_end_level1 || sys_collider_get_tile_array(player)==tile_end_level2 ){
                    //Con el world change hacemos que se creen los obejtos y nemigos correspodientes
                    world_change=1;
                    actual_world+=1;
                }
            }
        }
        //Mostramos el temporizador
        time=RealTimer();
        PutText(200,192,Itoa(time/60,"      ",10),0);
        //debug();

        //Pausa
        wait();
    }while(1);
}
















void man_game_update(){
    if (world_change==1){
        Cls();
        sys_entity_erase_all_objects();
        sys_entity_erase_all_enemies();
        array_enemies=sys_entity_get_array_structs_enemies();
        array_objects=sys_entity_get_array_structs_objects();
        SpriteOn();
        world_change=0;
        //Esto deshabilita la puerta para cambiar de mundo hasta que no se cojan las mondas
        enabled_world_change=0;

        if (actual_world==0){
            //Leemos el mapa
            load_file_into_buffer_with_structure("world0.bin");
            //Monedas que hay que recoger
            world_money=6;
            //Ponemos el player
            player->x=1*8;
            player->y=19*8;
            man_game_pintarMapa();
            //x=29,y=4
            destiny_x_door=29*8;
            destiny_y_door=2*8;
            //x=0, y=16
            destiny_x_phone=0;
            destiny_y_phone=15*8;
        }else if (actual_world==1){
            load_file_into_buffer_with_structure("world1.bin");
            player->x=4*8;
            player->y=20*8;
            world_money=6;
            man_game_pintarMapa();
            //x=2,y=6
            destiny_x_door=2*8;
            destiny_y_door=4*8;
            //28,11
            destiny_x_phone=28*8;
            destiny_y_phone=10*8;
        }else if (actual_world==2){
            player->x=3*8;
            player->y=20*8;
            world_money=6;
            load_file_into_buffer_with_structure("world2.bin");
            man_game_pintarMapa();
            //x=1,y=3
            destiny_x_door=1*8;
            destiny_y_door=1*8;
            //25,17
            destiny_x_phone=25*8;
            destiny_y_phone=16*8;
        }else if (actual_world==3){
            player->x=14*8;
            player->y=20*8;
            world_money=6;
            load_file_into_buffer_with_structure("world3.bin");
            man_game_pintarMapa();
        }else if (actual_world==4){
            player->x=20*8;
            player->y=19*8;
            world_money=6;
            load_file_into_buffer_with_structure("world4.bin");
            man_game_pintarMapa();
        }
        //Si el mundo ha cambiado, creamos los enemigos del mundo correspondiente
        for (int i=0;i<MAX_enemies;i++){ 
        TCoordinate_enemy* coordinate_enemy=&world_enemies[actual_world][i];
            TEntity *enemy=sys_entity_create_enemy1();
            enemy->x=coordinate_enemy->x;
            enemy->y=coordinate_enemy->y;
            enemy->type=coordinate_enemy->type;
            //enemy->dir=7;
            enemy->plane=enemy1_plane+sys_entity_get_num_enemies();
        }
        //Creamos los objetos del mundo correspondiente
        for (int i=0; i<MAX_objects;i++){
        TCoordinate_object* coordinate_object=&world_objects[actual_world][i];
            TEntity *object=sys_entity_create_object();
            object->y=coordinate_object->y;
            object->x=coordinate_object->x;
            object->type=coordinate_object->type;
            object->plane=object_money+sys_entity_get_num_objects();
        }
        //Pintamos la puntuacón una vez que hemos creado el numEnmeies
        pintar_HUD();
    }
}










void man_game_pintarMapa(){
    char numeroColumnas=32;
    char numeroFilas=23;
    char filaEnTileset=0;
    char columnaEnTileset=0;
    for (char f=0; f<numeroFilas;f++){
        for (char c=0; c<numeroColumnas;c++){
            //para tiles de 32*8 de ancho 23*8 de alto
            columnaEnTileset=(((buffer[c+(f*numeroColumnas)]/32)+1)*32)-(buffer[c+(f*numeroColumnas)]);
            resultado=(32-columnaEnTileset)*8;
            HMMM(resultado,(buffer[c+(f*numeroColumnas)]/32)*8+256, c*8,f*8,8,8);
        }
    }
}

void man_game_showBuffer(){
    Cls();
    Screen(1);
    unsigned int dir=0;
    printf("%d",&buffer[0]);
    printf("\r\n");
    int numeroColumnas=32;
    int numeroFilas=6;
    int columnaEnTileset=0;
    for (int f=4; f<numeroFilas;f++){
        printf("\r\nFila %d\r\n  ",f);
        for (int c=0; c<numeroColumnas;c++){
            columnaEnTileset=(((buffer[c+(f*numeroColumnas)]/32)+1)*32)-(buffer[c+(f*numeroColumnas)]);
            resultado=(32-columnaEnTileset)*8;
            printf("%d ",((buffer[c+(f*numeroColumnas)]/32)+1)*32);
            
        } 
    }
}
void man_game_copiarSpritesVRAM(){
    unsigned int sprite=0;
    unsigned int siguiente = 0;	
	for (char i=0; i<14; i++) {		
		//SetSpritePattern(sprite, &buffer[siguiente],32);
        //También es posible cargar los sprites como datos, si antes hemos sacado
        // los datos del spritedevtool, habilita el include
		SetSpritePattern(sprite, &SPRITE_DATA[siguiente],32);
       
        SC5SpriteColors(i, &COLOR_DATA[sprite]);
        
        sprite+=4;
   
		siguiente += 32;
        
	}
    //Ahora vamos a ponerle el color a los enemigos creados dinámicamente
    for (int i=enemy1_plane;i<object_money;i++){
        //SC5SpriteColors(i, &COLOR_DATA_ENEMY[i]);
    }
    //Ahora vamos a ponerle el color a los enemigos creados dinámicamente
    for (int i=object_money;i<object_money+10;i++){
        //SC5SpriteColors(i, &COLOR_DATA_MONEY[i]);
    }
    //Screen(1);
    //printf("%d", &buffer[0]);
	//Tablas patrones	
    //CopyRamToVram (&tab_sprites_from_fichero[0], dirBaseTablaSpritesPatrones, TAM_SpritesPatrones);
}

void wait(){
    __asm
      halt
      halt
      halt
  __endasm;
}
void man_game_cargar_buffer_musica(){
    enter_name_and_extension_in_structure( &TFileMusic, &fileNameSong[0]);
    fcb_open( &TFileMusic );
    fcb_read( &TFileMusic, &songBuffer[0], SONG_BUFFER_TAM );  
    fcb_close( &TFileMusic );
}
void man_game_reproducir_musica_y_efectos(){
    //Musica
    //DisableInterupt();
    PT3Rout();
    PT3Play();
    //Si se está reproduciendo un efecto se actualizará
    if (TestFX()==1){
      if (JIFFY!=0){
        JIFFY=0;
        UpdateFX();
      }
    }
    //EnableInterupt();
}

void man_game_cargar_buffer_efectos_sonido(){
   //afbdb es un puntero que está definido en ayfx_player.h
    afbdata=MMalloc(SONG_EFFECT_TAM);
    enter_name_and_extension_in_structure( &TFileEffects, "effects.afb");
    fcb_open( &TFileEffects );
    fcb_read( &TFileEffects, afbdata, SONG_EFFECT_TAM );  
    fcb_close( &TFileEffects );
}

void man_game_reproducir_efecto_sonido(char effect){
  //El 1 es un ruido flojo y corto
  //2 dos ruidos cortos y flojos
  // 3 un rebote
  // 4 son 5 captanillas que van desapareciendo
  // 5 3 captanillas cortas
  // 6 rayo laser pistola
  // 7 laser que va desapareciendo
  // 8 explosión que va desapareciendo
  // 9 golpe con explosión
  // 10 una especie de robot
  //man_game_sincronizaFX(150);
  PlayFX(effect);
}

void debug(){
    //void Rect ( int X1, int Y1, int X2, int Y2, int color, int OP )
    //void BoxFill (int X1, int Y1, int X2, int yY22, char color, char OP )
    //time=RealTimer();      // Read Current Timer Value
    //minutes=time/3000;           
    //secunds=time/50;
    //TEntity *object=&array_objects[0];
    BoxFill (0, 23*8, 256, 210, 6, LOGICAL_IMP );
    PutText(0,200,Itoa(sys_collider_get_tile_array(player),"  ",10),8);
    PutText(50,200,Itoa(tile_end_level1,"  ",10),8);
    PutText(100,200,Itoa(tile_end_level2,"  ",10),8);

    
 

    //printf("%d",buffer);
  
    //unsigned char *buf=getBuffer();
    //PutText(150,200,Itoa(buf[0],"  ",10),8);
    //PutText(0,200,Itoa(hours,"  ",10),8);
    //PutText(50,200,Itoa(minutes,"  ",10),8);
    //if(secunds>59)secunds=0;
    //PutText(100,200,Itoa(secunds-60,"  ",10),8);
    //memory_space=Peekw(0x0006);
    //PutText(150,200,Itoa(memory_space,"  ",10),8);
}

void pintar_HUD(){
    //Borramos todo el HUD
    BoxFill (0, 23*8, 256, 210, 4, LOGICAL_IMP );
    //Copiamos la casita
    HMMM(0,256+16,0,23*8,16,16);
    //Copiamos al personaje gris
    HMMM(2*8,256+16,5*8,23*8,16,16);
    //Copiamos el dibujo de puntuación
    HMMM(4*8,256+(2*8),12*8,24*8,16,8);
    //Copiamos las monedas
    HMMM(3*8,256,19*8,23*8,16,16);
    //Copiamos la flecha de las monedas
    HMMM(6*8,256+(2*8),21*8,24*8,8,8);
    PutText(20,192,Itoa(actual_world+1," ",10),8);
    PutText(60,192,Itoa(player->lives," ",10),8);
    PutText(120,192,Itoa(player->points," ",10),8);
    //PutText(150,192,"Need:",0);
    PutText(180,192,Itoa(sys_entity_get_num_objects()," ",10),8);    
}


