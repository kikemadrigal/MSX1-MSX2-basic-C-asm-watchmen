#pragma once
#include "./src/man/entity.c"
#include "./src/sys/anim.c"
//Para obtener el tile para subir por la escalera
#include "./src/sys/collider.c"
//Para obetenr la definición de los tiles
#include "./src/man/sprites.c"
////Para el man_game_reproducir_efecto_sonido y man_game_crear_disparo()
#include "./src/man/game.c"



//Declarations
void sys_physics_update(TEntity *entity);
void sys_physics_check_keyboard(TEntity *entity);
void entity_jump(TEntity *entity);


//Members
//char posicion_inicial_jump;
char contador_jump;
char array_jump[5];
//Definitions
void sys_physics_update(TEntity *entity){
    if (entity->type==entity_type_player){
        sys_physics_check_keyboard(entity);
        //Sistema de salto 2 parte
        if(entity->jump==1){
            entity->y+=entity->vy;
            if(entity->old_y-16>=entity->y){
                entity->vy*=-1;
                entity->jump=0;
            } 
        }
        //Colision con el margen izquierdo
        if(entity->x<=0) entity->x=0;
        else if(entity->x>=240) entity->x=240;
        //Colision con el margen inferior
        if(entity->y>180) entity->y=212-16;
          
        //Gravedad, bajará hasta que el tile de debajo sea suelo o escalera
        if (sys_collider_get_tile_down_array(entity)<tile_stairs1 || sys_collider_get_tile_down_array(entity)>=255){
            //Beep();
            entity->y+=entity->vy;
        } 



    }
    /*
    else if(entity->type==entity_type_shot){
        if (entity->dir==3)entity->x+=entity->vx;
        else if (entity->dir==7)entity->x-=entity->vx;
    }
    */

}



void sys_physics_check_keyboard(TEntity *entity){
    // Movement
    // 0=inactive  1=up 2=up & right 3=right 4=down & right 5=down 6=down & left 7=left 8=up & left 
    char joy = JoystickRead(0);
    int tile_derecha=sys_collider_get_tile_right_array(entity);
    int tile_izquierda=sys_collider_get_tile_left_array(entity);
    int tile_arriba=sys_collider_get_tile_up_array(entity);
    int tile_abajo=sys_collider_get_tile_down_array(entity);
    int tile_pie=sys_collider_get_tile_array(entity);
    //Movimiento hacia arriba
    if(joy==1){
        entity->dir=1;
        sys_anim_update(entity);
        //Irá hacia arriba solo si es uno de los tiles de la escalera
        if(tile_pie==tile_stairs1 || tile_pie==tile_stairs2 || tile_abajo==tile_stairs1 || tile_abajo==tile_stairs2 ){
            entity->y-=entity->vy;
        //Si debajo no tiene ninguna escalera y no está saltando, saltamos
        }else if(entity->jump==0){
            entity_jump(entity);
        }
    }
    //Arriba/derecha
    if(joy==2){
        entity->dir=2;
        sys_anim_update(entity);
        if(tile_derecha<tile_floor_tile || tile_derecha==255){
            entity->x+=entity->vx;
            entity_jump(entity); 
        }else{
            entity_jump(entity); 
        }
    
    }
        //Arriba/izquierda
    if(joy==8){
        entity->dir=8;
        sys_anim_update(entity);
        if(tile_izquierda<tile_floor_tile || tile_izquierda==255){
            entity_jump(entity);
            entity->x-=entity->vx; 
        }else{
            entity_jump(entity); 
        }
    }
    //Movimiento hacia la derecha
    if(joy==3){
        entity->dir=3;
        sys_anim_update(entity);
        if(tile_derecha<tile_floor_tile || tile_derecha==255)
            entity->x+=entity->vx;
    }
    if(joy==4){
        entity->dir=4;
    }
    //Hacia abajo
    if(joy==5){
        entity->dir=5;
        if(tile_abajo==tile_stairs1 ||tile_abajo==tile_stairs2 )
            entity->y+=entity->vy;
        sys_anim_update(entity);
        
    }  
    if(joy==6){
        entity->dir=6;
    }  
    //Movimiento hacia la izquierda
    if(joy==7) {
        entity->dir=7;
        sys_anim_update(entity);
        if(tile_izquierda<tile_floor_tile || tile_izquierda==255)
            entity->x-=entity->vx; 
    }


    //Leemos el disparo
    char trigger = TriggerRead(0);
    if (trigger!=0) {
        //man_game_crear_disparo_player(); 
        //man_game_reproducir_efecto_sonido(1);   
    }



}

//Sistema de salto 1 parte
void entity_jump(TEntity *entity){
    //Solo se puede saltar si no se está y aen un salto y si se está pegado a un sólido
    if (entity->jump==0 && sys_collider_get_tile_down_array(entity)>=tile_floor_tile && sys_collider_get_tile_down_array(entity)<255){
        //Activamos el salto
        entity->jump=1;  
        //invertimos la velocidad en y para que sume negativos y lo suba
        entity->vy*=-1;
        entity->old_y=entity->y;
    }
}




