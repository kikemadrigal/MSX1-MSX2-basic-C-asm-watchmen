
#pragma once
#include "fusion-c/header/msx_fusion.h"
//para el memset
#include <string.h>
//Para las funciones con archivos
#include "fusion-c/header/io.h"
//Para el printf
#include <stdio.h>

//Declarations
void enter_name_and_extension_in_structure(FCB *p_fcb, const char *p_name);
void load_file_into_buffer(char *filename);
void load_file_into_buffer_with_structure(char *p_name);

//Un buffer es una dirección de memoria utilizada para escribir en ella reiteradamente
//Lo utilizamos para cargar un sc5 y los archivos con los sprites
#define BUFFER_SIZE 27142
unsigned char buffer[BUFFER_SIZE];


//Getrs & setters
char* getBuffer(){
  return &buffer[0];
}
//Cargamos archivo en RAM
void load_file_into_buffer_with_structure(char *filename){
  FCB struct_fcb;
  //Le metemos el nombre y la extensión a la estructura
  enter_name_and_extension_in_structure(&struct_fcb, filename);
  fcb_open(&struct_fcb);
  //Si no omitimos los 8 primeros bytes (los que defininen la estructura del binario) aparecen  unas marcas arriba a la derecha
  fcb_read( &struct_fcb, &buffer[0], 8 ); 
  //Cargamos el archivo definido en la estructura y lo ponemos en la RAM (buffer)
  fcb_read( &struct_fcb, &buffer[0], BUFFER_SIZE );  
  fcb_close( &struct_fcb );
}

void load_file_into_buffer(char *filename) {
  int file;	// Set a file handler variable
  //byte buffer[Cabecera_Fichero];
  file=Open(filename, O_RDONLY);
  //printf("\n\rFichero %s abierto.", filename);
  // Se salta la cabecera
  Read(file, buffer, 7);	
  // Leyendo la tabla de patrones	de sprites
  Read(file, buffer, BUFFER_SIZE);
  Close(file);
  //printf("\n\rFichero %s leido.", filename);
}




void enter_name_and_extension_in_structure(FCB *p_fcb, const char *p_name)  // Routine servant à vérifier le format du nom de fichier
{
  char i, j;
  memset( p_fcb, 0, sizeof(FCB) );
  for( i = 0; i < 11; i++ ) {
    p_fcb->name[i] = ' ';
  }
  for( i = 0; (i < 8) && (p_name[i] != 0) && (p_name[i] != '.'); i++ ) {
    p_fcb->name[i] =  p_name[i];
  }
  if( p_name[i] == '.' ) {
    i++;
    for( j = 0; (j < 3) && (p_name[i + j] != 0) && (p_name[i + j] != '.'); j++ ) {
      p_fcb->ext[j] =  p_name[i + j] ;
    }
  }
}

