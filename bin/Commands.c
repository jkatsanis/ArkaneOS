#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

/// NEEDS TO HAVE THE FILE NAME INLUCED
void removeOldImage();
void compileFile(char* from, char* name_to_set);
void catFile(char* one, char* two);
void getFileName(char* file_name, char* file_path);
void cleanUp(char* file_one, char* file_two);

int main() {
    char first_path[100];
    char second_path[100];
    char file_one[100];
    char file_two[100];

    printf("This program merges 2 .asm files (Kernel & Bootloader) and creates a .img file out it\n");
    removeOldImage();
    printf("Enter first path: ");
    scanf("%s", first_path);

    printf("Enter second path: ");
    scanf("%s", second_path);

    printf("================\n");
    printf("=== DATA =======\n");
    printf("First path: %s\n", first_path);
    printf("Second path: %s\n", second_path);
    printf("================\n");

    compileFile(first_path, file_one);
    compileFile(second_path, file_two);

    printf("================\n");
    printf("=== DATA =======\n");
    printf("First name: %s\n", file_one);
    printf("Second name: %s\n", file_two);
    printf("================\n");

    catFile(file_one, file_two);

    system("dd if=result.bin of=Arkane.img bs=512 conv=notrunc");

    cleanUp(file_one, file_two);
    return 0;
}

void compileFile(char* from, char* name_to_set)
{ 
    char *fileName = strrchr(from, '/');  
    
     if (fileName != NULL) {
        fileName++;  // Move the pointer past the '/'
        char *extension = strrchr(fileName, '.');  // Find the last occurrence of '.'
        if (extension != NULL) {
            *extension = '\0';  // Null-terminate to remove the extension
        }
        
        printf("File Name without Extension: %s\n", fileName);
    } else {
        printf("File not found in the path.\n");
    }

    strcpy(name_to_set, fileName);

    char command[100];
    sprintf(command, "nasm -f bin -o %s.bin %s.asm", fileName, from);
    printf("Your COMPILE command: %s\n", command);
    system(command);
}

void catFile(char* one, char* two)
{
    char command[100];
    sprintf(command, "cat %s.bin %s.bin > result.bin", one, two);
    printf("Your CAT command: %s\n", command);
    system(command);
}

void cleanUp(char* file_one, char* file_two)
{
    char command_rm_one[100];
    sprintf(command_rm_one, "rm %s.bin", file_one);
    printf("Your RM command file one: %s\n", command_rm_one);
    system(command_rm_one);

    char command_rm_two[100];
    sprintf(command_rm_two, "rm %s.bin", file_two);
    printf("Your RM command file two: %s\n", command_rm_two);
    system(command_rm_two);

    printf("Your RM command result file: rm result.bin\n");
    system("rm result.bin"); 
}

void removeOldImage()
{
    const char *file_path = "Arkane.img"; 
    struct stat file_info;

    if (stat(file_path, &file_info) == 0) {
        system("rm Arkane.img");
    }
}