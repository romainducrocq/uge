//Chiffrement XOR

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 256 // Longueur maximale de la clef

void strip_newline(char* to_strip);
void encrypt_data(FILE* input_file, FILE* output_file, char *key);

int main(int argc, char* argv[])
{
	//Vérifier le nombre d'arguments
	if (argc != 3)
	{
		printf("Nombre d'arguments invalide. Il faut %d arguments.\n", argc);
		printf("Utilisation : %s inputfile outputfile\n", argv[0]);
		exit(0);
	}

	FILE* input;
	FILE* output;

	//Ouvrir les fichiers input et output
	input = fopen(argv[1], "r");
	output = fopen(argv[2], "w");


	//Vérifier la validité du fichier input
	if (input == NULL)
	{
		printf("Impossible de lire le fichier Input.\n");
		exit(0);
	}

	//Vérifier la validité du fichier de sortie
	if (output == NULL)
	{
		printf("Impossible d'ecrire sur le fichier de sortie.\n");
		exit(0);
	}

	//Key strings
	char *key = malloc(MAX_SIZE);

	//Prompt pour la clef
	printf("La clef : ");

	//Récupèrer la clef
	fgets(key, MAX_SIZE, stdin);

	printf("Chiffrement %s\n", argv[1]);

	//Supprimer le retour chariot de la clef
	strip_newline(key);

	//XOR des données avec la clef et sauvgarder le resultat dans le fichier output
	encrypt_data(input, output, key);

	printf("Encrypted data written to %s\n", argv[2]);

	//Release memory
	free(key);

	//Close files
	fclose(input);
	fclose(output);

	return 0;

}

void encrypt_data(FILE* input_file, FILE* output_file, char* key)
{
	int c;
	int i = 0;
	while ((c = getc(input_file)) != EOF) {
		putc(c ^ key[i % strlen(key)], output_file);
		i++;
	}
}

void strip_newline(char* to_strip)
{
	int i;
	for (i = 0; i <  strlen(to_strip); i++){
		if (to_strip[i] == '\n'){
			to_strip[i] = '\0';
			return;
		}
	}
}
