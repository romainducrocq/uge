#include <stdio.h>
#include <string.h>
#include "gmp.h"
#ifndef LONGMESSMAX
#define LONGMESSMAX 100
#endif

typedef unsigned char uchar;

void chaine2mpz(mpz_t chaine_mpz, uchar *chaine)
{
	long int longueur_chaine, i;
	longueur_chaine = strlen(chaine);
	mpz_set_ui(chaine_mpz, 0UL);

	for (i = 0; i < longueur_chaine; i++){
		mpz_add_ui(chaine_mpz, chaine_mpz, chaine[i] * pow(256,i));
	}
}

void mpz2chaine(char *str, mpz_t org_str_mpz)
{
	long int str_len, i;
	mpz_t max_mpz, c_mpz, str_mpz;
	mpz_init(max_mpz);
	mpz_init(c_mpz);
	mpz_init(str_mpz);
	mpz_set(str_mpz, org_str_mpz);
	/* Calcul de la longueur de la cha�ne */

		/* A COMPLETER */

	/* Conversion en cha�ne  */

      /* A COMPLETER */

	str[str_len] = '\0';
	mpz_clear(max_mpz);
	mpz_clear(c_mpz);
	mpz_clear(str_mpz);
}


void fabrique_les_clefs(mpz_t n, mpz_t e, mpz_t d, mpz_t str_mpz)
{
	mpz_t p, q, w, tmp;

	/* Initialisation des variables mpz_t locales */
	mpz_init(p);
	mpz_init(q);
	mpz_init(w);
	mpz_init(tmp);

	/* Prendre deux nombres premiers > str_mpz*/
	mpz_nextprime(p, str_mpz);
	mpz_nextprime(q, p);

	/* Calcul de n = p * q et w = (p-1)*(q-1) */
	mpz_mul(n, p, q);
	mpz_sub_ui(p, p, 1UL);
	mpz_sub_ui(q, q, 1UL);
	mpz_mul(w, p, q);

	/* Recherche d'un petit e en commen�ant par essayer 2 */
	mpz_set_ui(e, 2UL);
	mpz_gcd(tmp, e, w);
	while(mpz_cmp_ui(tmp, 1UL) != 0UL){
		mpz_add_ui(e, e, 1UL);
		mpz_gcd(tmp, e, w);
	}
	//printf("e: %Zd\n", e);
	//printf("w: %Zd\n", w);
	//printf("tmp: %Zd\n", tmp);

	/* Calcul de d */
	mpz_gcdext(tmp, d, NULL, e, w);
	while(mpz_cmp_ui(d, 0UL) < 0UL){
		mpz_add(d, d, w);
	}
	//printf("d: %Zd\n", d);

	/* C'est termin�: on nettoie la m�moire */
	mpz_clear(p);
	mpz_clear(q);
	mpz_clear(w);
	mpz_clear(tmp);
}

int main(){
	uchar message[LONGMESSMAX], message_dechiffre[LONGMESSMAX];
	mpz_t message_mpz, message_mpz_chiffre;
	mpz_t clef_publique_n, clef_publique_e, clef_privee;

	/* Initialisation des variables GMP */
	mpz_init(message_mpz); mpz_init(message_mpz_chiffre);
	mpz_init(clef_publique_n); mpz_init(clef_publique_e); mpz_init(clef_privee);

	/* Entr�e au clavier d'une cha�ne de caract�res */
	printf("Tapez votre message (Longueur max. = %d): ", LONGMESSMAX);
	fgets(message, LONGMESSMAX - 1, stdin);
	/* fgets permet de prendre en compte les espaces et les tabulations... */
	if(message[strlen(message) - 1] == '\n')
		message[strlen(message) - 1] = '\0';
        /* mais garde en g�n�ral le retour chariot de la fin! */

	/* Encodage du message en un entier long (Exo 2) */
	chaine2mpz(message_mpz, message);
	gmp_printf("Message de %d caract�res  -> %Zd\n\n", strlen(message), message_mpz);

	/* Fabrique des clefs */
	fabrique_les_clefs(clef_publique_n, clef_publique_e, clef_privee, message_mpz);
	gmp_printf("Clef_publique_n : %Zd\n", clef_publique_n);
	gmp_printf("Clef_publique_e : %Zd\n", clef_publique_e);
	gmp_printf("Clef_privee_d: %Zd\n", clef_privee);

	/* Chiffrement */
	mpz_powm(message_mpz_chiffre, message_mpz, clef_publique_e, clef_publique_n);
	gmp_printf("Message chiffr� : %Zd\n", message_mpz_chiffre);

	/* D�chiffrement */
	mpz_powm(message_mpz, message_mpz_chiffre, clef_privee, clef_publique_n);
	gmp_printf("Message d�chiffr� : %Zd\n", message_mpz);

	/* Retour � la cha�ne de caract�res (Exo 2) */
	mpz2chaine(message_dechiffre, message_mpz);
	gmp_printf("%s\n", message_dechiffre);

	/* Lib�ration de la m�moire utilis�e */
	mpz_clear(message_mpz); mpz_clear(message_mpz_chiffre);
	mpz_clear(clef_publique_n); mpz_clear(clef_publique_e); mpz_clear(clef_privee);
	return 0;
}
