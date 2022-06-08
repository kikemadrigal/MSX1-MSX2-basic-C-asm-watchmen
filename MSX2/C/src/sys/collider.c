#pragma once
#include "src/man/entity.c"
//Para el buffer
#include "src/man/files.c"

/**************DECLARACIONES************/
void sys_collider_init();

int sys_collider_get_file_entity(TEntity *entity);
int sys_collider_get_column_entity(TEntity *entity);
int sys_collider_get_tile_array(TEntity *entity);
int sys_collider_get_tile_right_array(TEntity *entity);
int sys_collider_get_tile_left_array(TEntity *entity);
int sys_collider_get_tile_up_array(TEntity *entity);
int sys_collider_get_tile_down_array(TEntity *entity);
int get_tile_down_left_array(TEntity *entity);
int get_tile_down_right_array(TEntity *entity);
char sys_collider_entity1_collider_entity(TEntity *entity1, TEntity *entity2);


/********FINAL DE DECLARAIONES***********/



/**************DEFINICIONES************/
void sys_collider_init(){

}

int sys_collider_get_column_entity(TEntity *entity){
  //Será la posición en x/8 pixeles el tile
  //El +6 es para compensar los pixeles en blanco del sprite
  return ((entity->x+6)/8);
}
int sys_collider_get_file_entity(TEntity *entity){
  //Será la posición y / 8 pixeles
  return (entity->y/8);
}
int sys_collider_get_tile_array(TEntity *entity){
  //Le sumamos 1 a la fila porque es un sprite de 16*16px, para ver el tile del pié
  int tile_pie=buffer[((sys_collider_get_file_entity(entity)+1)*32)+(sys_collider_get_column_entity(entity))];
  return tile_pie;
}
int sys_collider_get_tile_right_array(TEntity *entity){
  //Le sumamos 2 a la fila porque es un sprite de 16*16px, para ver el tile del suelo
  int tile_abajo=buffer[((sys_collider_get_file_entity(entity)+1)*32)+(sys_collider_get_column_entity(entity)+1)];
  return tile_abajo; 
}
int sys_collider_get_tile_left_array(TEntity *entity){
  //Le sumamos 2 a la fila porque es un sprite de 16*16px, para ver el tile del suelo
  int tile_abajo=buffer[((sys_collider_get_file_entity(entity)+1)*32)+(sys_collider_get_column_entity(entity)-1)];
  return tile_abajo; 
}
int sys_collider_get_tile_up_array(TEntity *entity){
  //Le sumamos 2 a la fila porque es un sprite de 16*16px, para ver el tile del suelo
  int tile_abajo=buffer[((sys_collider_get_file_entity(entity))*32)+(sys_collider_get_column_entity(entity))];
  return tile_abajo; 
}
int sys_collider_get_tile_down_array(TEntity *entity){
  //Le sumamos 2 a la fila porque es un sprite de 16*16px, para ver el tile del suelo
  int tile_abajo=buffer[((sys_collider_get_file_entity(entity)+2)*32)+(sys_collider_get_column_entity(entity))];
  return tile_abajo; 
}
int get_tile_down_left_array(TEntity *entity){
  int tile_down_left=buffer[((sys_collider_get_file_entity(entity)+2)*32)+(sys_collider_get_column_entity(entity))-1];
  return tile_down_left; 
}
int get_tile_down_right_array(TEntity *entity){
  int tile_down_right=buffer[((sys_collider_get_file_entity(entity)+2)*32)+(sys_collider_get_column_entity(entity))+1];
  return tile_down_right; 
}






char sys_collider_entity1_collider_entity(TEntity *entity1, TEntity *entity2){
    //if (enemiX < player.x + 16 &&  enemiX + 16 > player.x && enemiY < player.y + 32 && 16 + enemiY > player.y){
    if (entity2->x < entity1->x + 16 &&  entity2->x + 16 > entity1->x && entity2->y < entity1->y + 16 && 16 + entity2->y > entity1->y){
        return 1;
    }else{
        return 0;
    }
}