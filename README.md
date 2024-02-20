### OTUS-Linux-2023-10-L26 | Резервное копирование

Резервная копия снимается каждые 5 минут.
Служба для снятия бэкапа в файле: client/borg-backup.service

После получаса работы в репозитории такие файлы:
		<[root@client /]# borg list borg@192.168.11.160:/var/backup/
		etc-2024-02-20_12:36:12              Tue, 2024-02-20 12:36:13 [d6270dec4e3ee7285fb30044e6ce4a93a1f78235bb91fd29ebf43525a88849c4]
		etc-2024-02-20_12:41:48              Tue, 2024-02-20 12:41:49 [59d72c8682c81edb2ac952ca3a42339ed5e2b2f6307786b364b27f6fc2152110]
		etc-2024-02-20_12:47:48              Tue, 2024-02-20 12:47:49 [6ef670b589bc6aabf7d19352425263c5d38537bb6ea34d0fac8fcfbaf0d9d686]
		etc-2024-02-20_12:53:48              Tue, 2024-02-20 12:53:49 [bf44b1060d2d93562ebbd4af1f5822df657fd67cccaaf55813b393f8f035a69f]
		etc-2024-02-20_12:59:48              Tue, 2024-02-20 12:59:49 [eb0612e960b303ce4728c2594459ede90f73bb3c241c8387c77de16e1826e680]
		[root@client /]#>

Логи процесса бэкапа выглядят следующим образом:
		Feb 20 12:41:49 client borg[3548]: Archive name: etc-2024-02-20_12:41:48
		Feb 20 12:41:49 client borg[3548]: Archive fingerprint: 59d72c8682c81edb2ac952ca3a42339ed5e2b2f6307786b364b27f6fc2152110
		Feb 20 12:41:49 client borg[3548]: Time (start): Tue, 2024-02-20 12:41:49
		Feb 20 12:41:49 client borg[3548]: Time (end):   Tue, 2024-02-20 12:41:49
		Feb 20 12:41:49 client borg[3548]: Duration: 0.29 seconds
		Feb 20 12:41:49 client borg[3548]: Number of files: 1700
		Feb 20 12:41:49 client borg[3548]: Utilization of max. archive size: 0%
		Feb 20 12:41:49 client borg[3548]: ------------------------------------------------------------------------------
		Feb 20 12:41:49 client borg[3548]: Original size      Compressed size    Deduplicated size
		Feb 20 12:41:49 client borg[3548]: This archive:               28.43 MB             13.49 MB            126.42 kB
		Feb 20 12:41:49 client borg[3548]: All archives:              170.56 MB             80.96 MB             12.10 MB
		Feb 20 12:41:49 client borg[3548]: Unique chunks         Total chunks
		Feb 20 12:41:49 client borg[3548]: Chunk index:                    1306                10194
		Feb 20 12:41:49 client borg[3548]: ------------------------------------------------------------------------------

Посмотрель логи можно командой: journalctl -u borg-backup.service

Для восстановления из бэкапа нужно перейти в директорию в которую необходимо выполнить восстановление и выполнить команду borg extract:

		[root@client /]# rm -fr /etc/yum
		[root@client /]# ls -lh /etc/yum
		ls: cannot access /etc/yum: No such file or directory
		[root@client /]# borg list borg@192.168.11.160:/var/backup/
		etc-2024-02-20_12:53:48              Tue, 2024-02-20 12:53:49 [bf44b1060d2d93562ebbd4af1f5822df657fd67cccaaf55813b393f8f035a69f]
		etc-2024-02-20_12:59:48              Tue, 2024-02-20 12:59:49 [eb0612e960b303ce4728c2594459ede90f73bb3c241c8387c77de16e1826e680]
		etc-2024-02-20_13:04:48              Tue, 2024-02-20 13:04:49 [019ff28039f012389e8777abb1d75363cb116922ca4444c7067253f13d970011]
		etc-2024-02-20_13:10:48              Tue, 2024-02-20 13:10:49 [d28d82da429ad82676cd2299fc868fdf2b1298621ad489f0779ffdf550fbde58]
		etc-2024-02-20_13:16:48              Tue, 2024-02-20 13:16:49 [56226477d9e7ad707bf1375c70607bbaac3efde31436e11447aae811bd38bbfa]
		[root@client /]# borg extract borg@192.168.11.160:/var/backup/::etc-2024-02-20_13:16:48 etc/yum/ 
		[root@client /]# ls -lh /etc/yum
		total 4.0K
		drwxr-xr-x. 2 root root   6 Apr  2  2020 fssnap.d
		drwxr-xr-x. 2 root root  54 Apr 30  2020 pluginconf.d
		drwxr-xr-x. 2 root root  26 Apr 30  2020 protected.d
		drwxr-xr-x. 2 root root  37 Apr  2  2020 vars
		-rw-r--r--. 1 root root 444 Apr  2  2020 version-groups.conf
		[root@client /]# 