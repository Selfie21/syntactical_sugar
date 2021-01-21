// Fehler im Programm: Die Sends und Receives auf den jeweiligen Threads blocken bis der Speicher wieder benutzt wird/empfangen wird. Das kann dazu führen das ein Send sendet und das andere wartet. Wahrscheinlich wird die message beim Kunden nicht zwischengespeichert.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mpi.h>

int main(int argc, char* argv[]) {
	MPI_Init(&argc, &argv);

	int my_rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);

	if (my_rank < 2) {
		int        other_rank = 1 - my_rank;
		int        tag        = 0;
		char       send_message[14];
		char			 recv_message[14];
		sprintf(send_message, "Hello, I am %d", my_rank);
		MPI_Status status;
		
		if(my_rank == 0){
			MPI_Send(send_message, strlen(send_message) + 1, MPI_CHAR, other_rank, tag, MPI_COMM_WORLD);
			MPI_Recv(recv_message, 100, MPI_CHAR, other_rank, tag, MPI_COMM_WORLD, &status);
			printf("%s\n", recv_message);
		}else{
			MPI_Recv(recv_message, 100, MPI_CHAR, other_rank, tag, MPI_COMM_WORLD, &status);
			printf("%s\n", recv_message);
			MPI_Send(send_message, strlen(send_message) + 1, MPI_CHAR, other_rank, tag, MPI_COMM_WORLD);
		}
	}

	MPI_Finalize();
	return EXIT_SUCCESS;
}

// Weitere Lösunge wäre das Verwenden von ersetzen mit MPI_Isend und MPI_Irecv das nicht blockiert.
