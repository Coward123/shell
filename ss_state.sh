#! /bin/sh

ss -a | awk '
BEGIN{ FS = " "; }
{
    if(1 != NR)
    {
        conn_state[$1] ++;
        recv_q[$1] += $2;
        send_q[$1] += $3;
    }
}

END{
    total_conn = 0;
    total_recv_q = 0;
    total_send_q = 0;
    for (state in conn_state)
    {
        total_conn += conn_state[ state ];
        total_recv_q += recv_q[ state ];
        total_send_q += send_q[ state ];
    }
    
    printf("-----------------------------------------------------------------------------------------------------\n");
    printf("state           conn_num        (%)             recv-q          (%)             send-q          (%)  \n");
    for (state in conn_state)
    {
        printf ("%-15s %-15d %-15.2f %-15d %-15.2f %-15d %-15.2f \n" ,
                state, 
                conn_state[ state ], 0 == total_conn ? 0 : (conn_state[ state ]/total_conn)*100,
                recv_q[ state ], 0 == total_recv_q ? 0 : (recv_q[ state ]/total_recv_q)*100,
                send_q[ state ], 0 == total_send_q ? 0 : (send_q[ state ]/total_send_q)*100);
    }

    printf("\n");
    printf("[total] conn: %d,  recv-q: %d,  send-q:  %d\n", total_conn, total_recv_q, total_send_q);
    printf("-----------------------------------------------------------------------------------------------------\n");
}' 
