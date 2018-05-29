#! /bin/sh

ss -a | awk '
BEGIN{ FS="[ :]+" }
{
    if(1 != NR)
    {
        if($1 !~ /LISTEN/)
        {
            #printf("ipaddr: %s\n", $6);
            peer[$6] ++;
        }
    }
}

END{
    peer_num = 0;
    conn_num = 0;
    for (ipaddr in peer)
    {
        peer_num ++;
        conn_num += peer[ ipaddr ];
    }

    printf("-----------------------------------------------------------------------------------------------------\n");
    printf("peer                             conn_num        %\n");
    #for (ipaddr in peer)
    #{
    #    printf ("%-32s %-15d \n" , ipaddr, peer[ ipaddr ]);
    #}

    for( i = 0; i < 20; i ++)
    {
        #printf("i = %d\n", i);
        max_conn_num = 0;
        max_conn_ipaddr = "N.A";
        for (ipaddr in peer)
        {
            if(max_conn_num < peer[ ipaddr ])
            {
                max_conn_num = peer[ ipaddr ];
                max_conn_ipaddr = ipaddr
            }
        }
        printf ("%-32s %-15d %-15.2f\n" , max_conn_ipaddr, max_conn_num, (max_conn_num / conn_num) * 100 );
        peer[ max_conn_ipaddr ] = 0;
    }
    printf("\n");
    printf("[total] peer: %d, conn: %d\n", peer_num, conn_num);
    printf("-----------------------------------------------------------------------------------------------------\n");
}'
