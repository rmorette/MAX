;' $Header:   P:/PVCS/MAX/386MAX/UTIL_MSG.ASV   1.5   08 Jul 1998 12:30:10   BOB  $
	 title	 UTIL_MSG -- 386MAX Message Text
	 page	 58,122
	 name	 UTIL_MSG

COMMENT|		Module Specifications

Copyright:  (C) Copyright 1987-98 Qualitas, Inc.  GNU General Public License version 3.

Segmentation:  Group PGROUP:
	       Data    segment DATA,	dword-aligned, public, class 'data'

Program derived from:  None.

Original code by:  Bob Smith, April, 1987.

Modifications by:  None.

|

.386
.xlist
	 include MASM.INC
	 include ASCII.INC
NOVER_HTU = 1
	 include VERSION.INC

	 include QMAX_OEM.INC
if @OEM_BETA
	 include VERSBETA.INC
endif				; IF @OEM_BETA

if @OEM_SYS eq @OEMSYS_HPRS
	 extrn	 VERS_HP:abs
endif				; IF @OEM_SYS eq @OEMSYS_HPRS
	 extrn	 VERSLTR1:abs
.list

PGROUP	 group	 DATA


DATA	 segment use16 dword public 'data' ; Start DATA segment
	 assume  ds:PGROUP

ifndef HILO
	 public  MSG_COPY
if @OEM_SYS eq @OEMSYS_OL2
MSG_COPY db	 'Memory Manager '
	 db	 '-- Version '
else
MSG_COPY db	 @OEM_TEXT
	 db	 (MSG_COPY+15-$) dup (' '),'-- Version '
endif				; IF @OEM_SYS eq @OEMSYS_OL2
if @OEM_SYS eq @OEMSYS_HPRS
	 db	 VERS_HP,'.0'
endif				; IF @OEM_SYS eq @OEMSYS_HPRS
	 db	 VERS_H,'.',VERS_T,VERS_U
if @OEM_BETA
	 db	 '.',BETA_H,BETA_T,BETA_U,'�'
else
	 db	 VERSLTR1
endif				; IF @OEM_BETA
	 db	 ' -- ',@OEM_SUBT,CR,LF
	 db	 '   (C) Copyright 1987-98 Qualitas, Inc.'
ifdef LANG_GR
	 db	 '  Alle Rechte vorbehalten.',CR,LF
else
	 db	 '  GNU General Public License version 3.',CR,LF
endif				; IFDEF LANG_GR
if @OEM_SYS eq @OEMSYS_OLI
	 db	 '   Copyright (C) Olivetti Inc., 1989-98  GNU General Public License version 3',CR,LF
endif				; IF @OEM_SYS eq @OEMSYS_OLI
	 db	 EOS

	 public  MSG_NOT386,MSG_NOT386_LEN
ifdef LANG_GR
MSG_NOT386 db	 BEL,'��> falscher Maschinentyp,',CR,LF
	 db	     '    erfordert einen 80386.',CR,LF
else
MSG_NOT386 db	 BEL,'��> Wrong machine type',CR,LF
	 db	     '    Must run on an 80386.',CR,LF
endif				; IFDEF LANG_GR
MSG_NOT386_LEN equ $-MSG_NOT386

if @OEM_SYS eq @OEMSYS_HPRS
	 public  MSG_NOTPRES,MSG_NOTPRES_LEN
ifdef LANG_GR
MSG_NOTPRES db	 BEL,'��> ',@OEM_FILE,' nicht gefunden -- "Device=',@OEM_FILE,'.SYS" in CONFIG.SYS',CR,LF
	 db	     '    und ',@OEM_FILE,'.SYS auf der System-Disk erforderlich.',CR,LF
else
MSG_NOTPRES db	 BEL,'��> ',@OEM_FILE,' not found -- Add "Device=',@OEM_FILE,'.SYS" to CONFIG.SYS',CR,LF
	 db	     '    and ensure that ',@OEM_FILE,'.SYS is on your system disc.',CR,LF
endif				; IFDEF LANG_GR
MSG_NOTPRES_LEN equ $-MSG_NOTPRES

	 public  MSG_NOTVER,MSG_NOTVER_LEN
ifdef LANG_GR
MSG_NOTVER db	 BEL,'��> falsche ',@OEM_FILE,'.SYS Version installiert;',CR,LF
	 db	     '    erfordert ',@OEM_FILE,'.SYS und ',@OEM_FILE,'.COM in gleicher Version.',CR,LF
else
MSG_NOTVER db	 BEL,'��> Incorrect version of ',@OEM_FILE,'.SYS installed',CR,LF
	 db	     '    Ensure that ',@OEM_FILE,'.SYS and ',@OEM_FILE,'.COM are the same version.',CR,LF
endif				; IFDEF LANG_GR
MSG_NOTVER_LEN equ $-MSG_NOTVER
else
	 public  MSG_NOTPRES,MSG_NOTPRES_LEN
if @OEM_SYS eq @OEMSYS_NEC
ifdef LANG_GR
MSG_NOTPRES db	 BEL,'��> NEC Version des ',@OEM_FILE,'.SYS nicht geladen von CONFIG.SYS.',CR,LF
else
MSG_NOTPRES db	 BEL,'��> NEC version of ',@OEM_FILE,'.SYS device driver not loaded from CONFIG.SYS.',CR,LF
endif				; IFDEF LANG_GR
elseif @OEM_SYS eq @OEMSYS_OL2
ifdef LANG_GR
MSG_NOTPRES db	 BEL,'��> Memory Manager Einheiten-Treiber nicht geladen von CONFIG.SYS.',CR,LF
else
MSG_NOTPRES db	 BEL,'��> Memory Manager device driver not loaded from CONFIG.SYS.',CR,LF
endif				; IFDEF LANG_GR
else
ifdef LANG_GR
MSG_NOTPRES db	 BEL,'��> ',@OEM_FILE,'.SYS Einheiten-Treiber nicht geladen von CONFIG.SYS.',CR,LF
else
MSG_NOTPRES db	 BEL,'��> ',@OEM_FILE,'.SYS device driver not loaded from CONFIG.SYS.',CR,LF
endif				; IFDEF LANG_GR
				; IF @OEM_SYS eq @OEMSYS_OL2
endif				; IF @OEM_SYS eq @OEMSYS_NEC
MSG_NOTPRES_LEN equ $-MSG_NOTPRES

	 public  MSG_DEFUNCT
ifdef LANG_GR
MSG_DEFUNCT db	 BEL,'��> Funktion nicht mehr unterst�tzt.',CR,LF,EOS
else
MSG_DEFUNCT db	 BEL,'��> Function no longer supported.',CR,LF,EOS
endif
	 public  MSG_NOTVER,MSG_NOTVER_LEN
if @OEM_SYS eq @OEMSYS_OL2
ifdef LANG_GR
MSG_NOTVER db	 BEL,'��> Memory Manager hat falsche Versionsnummer.',CR,LF
else
MSG_NOTVER db	 BEL,'��> Incorrect Memory Manager version number.',CR,LF
endif				; IFDEF LANG_GR
else
ifdef LANG_GR
MSG_NOTVER db	 BEL,'��> Programm ',@OEM_TEXT,' hat falsche Versionsnummer.',CR,LF
else
MSG_NOTVER db	 BEL,'��> Incorrect ',@OEM_TEXT,' version number.',CR,LF
endif				; IFDEF LANG_GR
endif				; IF @OEM_SYS eq @OEMSYS_OL2
MSG_NOTVER_LEN equ $-MSG_NOTVER
endif				; IF @OEM_SYS eq @OEMSYS_HPRS

	 public  MSG_NOTFND,MSG_NOTFND1,MSG_NOTFND_CUR,MSG_NOTFND_LEN
ifdef LANG_GR
MSG_NOTFND db	 BEL,'��> unerkannter Parameter in der Befehlszeile',CR,LF
MSG_NOTFND1 db	     '    g�ltige Optionen sind '
else
MSG_NOTFND db	 BEL,'��> Unrecognized Parameter on Command Line',CR,LF
MSG_NOTFND1 db	     '    Valid options are '
endif				; IFDEF LANG_GR
MSG_NOTFND_CUR equ $-MSG_NOTFND1-1
MSG_NOTFND_LEN equ $-MSG_NOTFND


if @OEM_HIFILL
	 public  AZS_ERRMAC,MSG_CLOSMAC,MSG_CLOSMAC_LEN
AZS_ERRMAC label byte
ifdef LANG_GR
MSG_CLOSMAC db	  BEL,'��> Fehler in Speicher-Zuordnungskette.',CR,LF
else
MSG_CLOSMAC db	  BEL,'��> Memory allocation chain error.',CR,LF
endif				; IFDEF LANG_GR
MSG_CLOSMAC_LEN equ $-MSG_CLOSMAC
	 db	 0
endif				; IF @OEM_HIFILL
endif				; IFNDEF HILO


	 public  MSG_NOROOM,MSG_NOROOM1,MSG_NOROOM2,MSG_NOROOM3
	 public  MSG_NOROOM_LEN
ifdef LANG_GR
MSG_NOROOM db	 BEL,'��> Kein Platz im HiDOS Speicher.',CR,LF
	 db	     '    '
MSG_NOROOM1 db	     ' _ KB verf�gbar:  '
MSG_NOROOM2 db	     ' _ KB ben�tigt f�r COMMAND.COM, '
MSG_NOROOM3 db	     ' _ KB f�r ',@OEM_FILE,'.COM.',CR,LF
else
MSG_NOROOM db	 BEL,'��> No room in high DOS memory.',CR,LF
	 db	     '    '
MSG_NOROOM1 db	     ' _ KB available:  '
MSG_NOROOM2 db	     ' _ KB needed for COMMAND.COM, '
MSG_NOROOM3 db	     ' _ KB for ',@OEM_FILE,'.COM.',CR,LF
endif				; IFDEF LANG_GR
MSG_NOROOM_LEN equ $-MSG_NOROOM

	 public  MSG_NOHIGH,MSG_NOHIGH_LEN
ifdef LANG_GR
MSG_NOHIGH db	 BEL,'��> kein HiDOS Speicher verf�gbar.',CR,LF
else
MSG_NOHIGH db	 BEL,'��> No high DOS memory available.',CR,LF
endif				; IFDEF LANG_GR
MSG_NOHIGH_LEN equ $-MSG_NOHIGH

	 public  MSG_CLOSHI,MSG_CLOSHI_LEN
ifdef LANG_GR
MSG_CLOSHI db	 BEL,'��> HiDOS Speicher nicht verf�gbar.',CR,LF
else
MSG_CLOSHI db	 BEL,'��> High DOS memory unavailable.',CR,LF
endif				; IFDEF LANG_GR
MSG_CLOSHI_LEN equ $-MSG_CLOSHI

	 public  MSG_CLOSHI_OFF,MSG_OPENHI_ON
ifdef LANG_GR
MSG_CLOSHI_OFF db '��> HiDOS Speicher geschlossen.',CR,LF,EOS
MSG_OPENHI_ON  db '��> HiDOS Speicher er�ffnet.',CR,LF,EOS
else
MSG_CLOSHI_OFF db '��> High DOS memory closed off.',CR,LF,EOS
MSG_OPENHI_ON  db '��> High DOS memory opened up.',CR,LF,EOS
endif				; IFDEF LANG_GR

	 public  MSG_RELEASE
ifdef LANG_GR
MSG_RELEASE db	 '��> lade Programme nach Freigabe in unteren Speicher (LoDOS) ...',CR,LF,EOS
else
MSG_RELEASE db	 '��> Loading programs in LOW memory after release...',CR,LF,EOS
endif				; IFDEF LANG_GR

	 public  MSG_USED,MSG_USED1,MSG_USED2
MSG_USED db	 '��>   _'
ifdef LANG_GR
MSG_USED1 db	 ' KB im HiDOS Speicher belegt,   _'
MSG_USED2 db	 ' KB verf�gbar.',CR,LF,EOS
else
MSG_USED1 db	 ' KB used in HIGH memory,   _'
MSG_USED2 db	 ' KB available.',CR,LF,EOS
endif				; IFDEF LANG_GR

ifndef HILO
if @OEM_HILOAD
	 public  MSG_RUNHI,MSG_RUNLO
ifdef LANG_GR
MSG_RUNHI db	 '��> lade Programme in oberen Speicher (HiDOS) ...',CR,LF,EOS
MSG_RUNLO db	 '��> lade Programme in unteren Speicher (LoDOS) ...',CR,LF,EOS
else
MSG_RUNHI db	 '��> Loading programs in HIGH memory...',CR,LF,EOS
MSG_RUNLO db	 '��> Loading programs in LOW memory...',CR,LF,EOS
endif				; IFDEF LANG_GR

	 public  MSG_AVAIL,MSG_AVAIL1
MSG_AVAIL db	 '��>   _'
ifdef LANG_GR
MSG_AVAIL1 db	 ' KB im HiDOS Speicher verf�gbar',EOS
else
MSG_AVAIL1 db	 ' KB available in HIGH memory',EOS
endif				; IFDEF LANG_GR

	 public  MSG_BLK,MSG_BLK1
ifdef LANG_GR
MSG_BLK  db	 ', gr��ter Block ist   _'
else
MSG_BLK  db	 ', largest block is   _'
endif				; IFDEF LANG_GR
MSG_BLK1 db	 ' KB',EOS

	 public  MSG_DOT
MSG_DOT  db	 '.',CR,LF,EOS
endif				; IF @OEM_HILOAD

	 public  MSG_LIST
ifdef LANG_GR
MSG_LIST db	 'Extended Memory Belegung ...',CR,LF,EOS
else
MSG_LIST db	 'Extended memory usage...',CR,LF,EOS
endif				; IFDEF LANG_GR

	 public  MSG_PRG,MSG_PRG1
ifdef LANG_GR
MSG_PRG  db	 '  Programmspeicher      ='
else
MSG_PRG  db	 '  Program storage       ='
endif				; IFDEF LANG_GR
MSG_PRG1 db	 '     _ KB',CR,LF,EOS

	 public  MSG_MAP,MSG_MAP1,MSG_MAP2
ifdef LANG_GR
MSG_MAP  db	 '  ROM Abbildungsbereich ='
else
MSG_MAP  db	 '  ROM mapping region    ='
endif				; IFDEF LANG_GR
MSG_MAP1 db	 '     0 KB'
MSG_MAP2 db	 CR,LF,EOS,79 dup (' ')

if @OEM_HIFILL
	 public  MSG_OVR,MSG_OVR1,MSG_OVR2
ifdef LANG_GR
MSG_OVR  db	 '  HiDOS Speicher        ='
else
MSG_OVR  db	 '  High DOS memory       ='
endif				; IFDEF LANG_GR
MSG_OVR1 db	 '     _ KB'
MSG_OVR2 db	 CR,LF,EOS,79 dup (' ')
endif				; IF @OEM_HIFILL

	 public  MSG_LOW,MSG_LOW1
ifdef LANG_GR
MSG_LOW  db	 '  LoDOS Speicher        ='
else
MSG_LOW  db	 '  Low  DOS memory       ='
endif				; IFDEF LANG_GR
MSG_LOW1 db	 '     _ KB',CR,LF,EOS

	 public  MSG_EMM,MSG_EMM1
ifdef LANG_GR
MSG_EMM  db	 '  verf�gbar dynamisch   ='
else
MSG_EMM  db	 '  Avail Shared memory   ='
endif				; IFDEF LANG_GR
MSG_EMM1 db	 '     _ KB',CR,LF,EOS

	 public  MSG_EXT,MSG_EXT1
ifdef LANG_GR
MSG_EXT  db	 '  Rest Extended Memory  ='
else
MSG_EXT  db	 '  Remaining ext memory  ='
endif				; IFDEF LANG_GR
MSG_EXT1 db	 '     _ KB',CR,LF,EOS

	 public  MSG_TOT,MSG_TOT1
ifdef LANG_GR
MSG_TOT  db	 'gesamt Extended Memory  ='
else
MSG_TOT  db	 'Total extended memory   ='
endif				; IFDEF LANG_GR
MSG_TOT1 db	 '     _ KB',EOS

	 public  MSG_SHD,MSG_SHD1
ifdef LANG_GR
MSG_SHD  db	 ', reserv. Speicher gewonnen '
else
MSG_SHD  db	 ', reserved memory recovered '
endif				; IFDEF LANG_GR
MSG_SHD1 db	 '=    _ KB',EOS

if @OEM_EMSLIST
	 public  MSG_EXP,MSG_EXP1,MSG_EXPINUSE,MSG_EXPAVAIL
ifdef LANG_GR
MSG_EXP  db	 'gesamt EMS Speicher ='
MSG_EXP1 db	 '     _ KB, belegt = '
MSG_EXPINUSE db  '   _ KB, verf�gbar = '
MSG_EXPAVAIL db  '   _ KB',CR,LF,EOS
else
MSG_EXP  db	 'Total EMS memory   ='
MSG_EXP1 db	 '     _ KB, in use = '
MSG_EXPINUSE db  '   _ KB, available = '
MSG_EXPAVAIL db  '   _ KB',CR,LF,EOS
endif				; IFDEF LANG_GR
endif				; IF @OEM_EMSLIST


	 public  MSG_STATE_OFF
	 public  MSG_STATE_ON
	 public  MSG_STATE_AUTO0
	 public  MSG_STATE_AUTO1
	 if	 @OEM_SYS eq @OEMSYS_HPRS
MSG_STATE_OFF db   @OEM_FILE,'  OFF.',CR,LF,EOS
MSG_STATE_ON  db   @OEM_FILE,'  ON.',CR,LF,EOS
ifdef LANG_GR
MSG_STATE_AUTO0 db @OEM_FILE,'  AUTO inaktiv.',CR,LF,EOS
MSG_STATE_AUTO1 db @OEM_FILE,'  AUTO aktiv.',CR,LF,EOS
else
MSG_STATE_AUTO0 db @OEM_FILE,'  AUTO inactive.',CR,LF,EOS
MSG_STATE_AUTO1 db @OEM_FILE,'  AUTO active.',CR,LF,EOS
endif				; IFDEF LANG_GR
	 else
ifdef LANG_GR
MSG_STATE_OFF db   'aktueller Status ist OFF.',CR,LF,EOS
MSG_STATE_ON  db   'aktueller Status ist ON.',CR,LF,EOS
MSG_STATE_AUTO0 db 'aktueller Status ist AUTO inaktiv.',CR,LF,EOS
MSG_STATE_AUTO1 db 'aktueller Status ist AUTO aktiv.',CR,LF,EOS
else
MSG_STATE_OFF db   'The current state is OFF.',CR,LF,EOS
MSG_STATE_ON  db   'The current state is ON.',CR,LF,EOS
MSG_STATE_AUTO0 db 'The current state is AUTO inactive.',CR,LF,EOS
MSG_STATE_AUTO1 db 'The current state is AUTO active.',CR,LF,EOS
endif				; IFDEF LANG_GR
	 endif			; IF @OEM_SYS eq @OEMSYS_HPRS

	 public  MSG_FORCE,MSG_FORCE_LEN
if @OEM_SYS eq @OEMSYS_HPRS
ifdef LANG_GR
MSG_FORCE db	 BEL,'��> Expanded Memory belegt -- kann nicht in den OFF Status schalten;',CR,LF
	 db	     '    entfernen Sie residente Programme, die EMS benutzen.',CR,LF
else
MSG_FORCE db	 BEL,'��> Expanded Memory in Use -- Unable to change to OFF state',CR,LF
	 db	     '    Remove resident program using expanded memory.',CR,LF
endif				; IFDEF LANG_GR
MSG_FORCE_LEN equ $-MSG_FORCE	; Message length
else
ifdef LANG_GR
MSG_FORCE db	 BEL,'��> Expanded, Extended, LoDOS oder HiDOS belegt -- OFF Status unm�glich',CR,LF
else
MSG_FORCE db	 BEL,'��> Expanded, Extended, Low or High DOS Memory in Use -- Unable to turn OFF',CR,LF
endif				; IFDEF LANG_GR
MSG_FORCE_LEN equ $-MSG_FORCE	; Message length
endif				; IF @OEM_SYS eq @OEMSYS_HPRS

	 public  MSG_EXTINUSE,MSG_EXTINUSE_LEN
ifdef LANG_GR
MSG_EXTINUSE db  BEL,'��> Extended Memory belegt -- kann nicht in ON oder AUTO Status schalten;',CR,LF
	 db	     '    entfernen Sie residente Programme, die Extended Memory benutzen.',CR,LF
else
MSG_EXTINUSE db  BEL,'��> Extended Memory in Use -- Unable to change to ON or AUTO state',CR,LF
	 db	     '    Remove resident program using extended memory.',CR,LF
endif				; IFDEF LANG_GR
MSG_EXTINUSE_LEN equ $-MSG_EXTINUSE ; Message length

if @OEM_WTK
	 public  MSG_WTK,MSG_WTK_LEN
ifdef LANG_GR
MSG_WTK  db	 BEL,'��> Weitek FPA benutzt -- kann nicht in den OFF Status schalten',CR,LF
else
MSG_WTK  db	 BEL,'��> Weitek FPA in Use -- Unable to change to OFF state',CR,LF
endif				; IFDEF LANG_GR
MSG_WTK_LEN equ  $-MSG_WTK	; Message length
endif				; IF @OEM_WTK

	 public  MSG_OFF,MSG_OFF_LEN
ifdef LANG_GR
MSG_OFF  db	 BEL,'��> Funktion w�hrend OFF Status nicht verf�gbar.',CR,LF
else
MSG_OFF  db	 BEL,'��> Function unavailable while OFF.',CR,LF
endif				; IFDEF LANG_GR
MSG_OFF_LEN equ  $-MSG_OFF	; Message length

	 public  MSG_NOWTK
ifdef LANG_GR
MSG_NOWTK db	 BEL,'��> Weitek FPA nicht gefunden.',CR,LF,EOS
else
MSG_NOWTK db	 BEL,'��> Weitek FPA not found.',CR,LF,EOS
endif				; IFDEF LANG_GR

	 public  MSG_WTK0,MSG_WTK1
ifdef LANG_GR
MSG_WTK0 db	 'Weitek Unterst�tung ausgeschaltet (OFF).',CR,LF,EOS
MSG_WTK1 db	 'Weitek Unterst�tzung eingeschaltet (ON).',CR,LF,EOS
else
MSG_WTK0 db	 'Weitek support OFF.',CR,LF,EOS
MSG_WTK1 db	 'Weitek support ON.',CR,LF,EOS
endif				; IFDEF LANG_GR

	 public  MSG_WTKHMA
ifdef LANG_GR
MSG_WTKHMA db	 BEL,'��> HMA belegt, kann Weitek Unterst�tzung nicht einschalten.',CR,LF,EOS
else
MSG_WTKHMA db	 BEL,'��> HMA in use, unable to enable Weitek support.',CR,LF,EOS
endif				; IFDEF LANG_GR

endif				; IFNDEF HILO

if @OEM_WIN3
	 public  MSG_WINERR
ifdef LANG_GR
MSG_WINERR db	 BEL,'��> Funktion unter Windows nicht verf�gbar.',CR,LF,EOS
else
MSG_WINERR db	 BEL,'��> Function unavailable under Windows.',CR,LF,EOS
endif				; IFDEF LANG_GR
endif				; IF @OEM_WIN3

ifdef LANG_GR
COMMENT|
������������������������������������������͸
�	     DOS STACKS BELEGUNG	   �
������������������������������������������Ĵ
�					   �
�	   Es gibt __ DOS Stacks,	   �
�	      L�nge je ____ Byte.	   �
�					   �
� HW Interrupts __			   �
�		__			   �
�					   �
� Aktueller Status ist .....		   �
�					   �
������������������������������������������Ĵ
�  Adresse  �  Status  � Stack Top � Tiefe �
������������������������������������������Ĵ
� ____:____ � ________ � ____:____ �   ___ �
������������������������������������������;
|

	 public  CNTBUF,CNTBUF_CNT,CNTBUF_ISIZ
	 public  CNTBUF_MPIC,CNTBUF_SPIC,CNTBUF_TAIL
	 public  CNTBUF_STATE
CNTBUF	 db	 '������������������������������������������͸',CR,LF
	 db	 '�           DOS STACKS BELEGUNG            �',CR,LF
	 db	 '������������������������������������������Ĵ',CR,LF
	 db	 '�                                          �',CR,LF
	 db	 '�         Es gibt  '
CNTBUF_CNT db	 '_ DOS Stacks,           �',CR,LF
	 db	 '�            L�nge je    '
CNTBUF_ISIZ db	 '_ Byte.           �',CR,LF
	 db	 '�                                          �',CR,LF
	 db	 '� HW Interrupts  '
CNTBUF_MPIC db	 '                          �',CR,LF
	 db	 '�                '
CNTBUF_SPIC db	 '                          �',CR,LF
	 db	 '�                                          �',CR,LF
	 db	 '� Aktueller Status ist '
CNTBUF_STATE db  '                    �',CR,LF
	 db	 '�                                          �',CR,LF
	 db	 '������������������������������������������Ĵ',CR,LF
	 db	 '�  Adresse  �  Status  � Stack Top � Tiefe �',CR,LF
	 db	 '������������������������������������������Ĵ',CR,LF,EOS
CNTBUF_TAIL db	 '������������������������������������������;',CR,LF,EOS

	 public  CNTBUF_STATE_ON,CNTBUF_STATE_ON_LEN
CNTBUF_STATE_ON  db 'AKTIV.   '
CNTBUF_STATE_ON_LEN equ $-CNTBUF_STATE_ON

	 public  CNTBUF_STATE_OFF,CNTBUF_STATE_OFF_LEN
CNTBUF_STATE_OFF db 'INAKTIV. '
CNTBUF_STATE_OFF_LEN equ $-CNTBUF_STATE_OFF

	 public  MSG_DSTKS_ON,MSG_DSTKS_OFF
MSG_DSTKS_ON db  'DOS Stacks sind nun aktiv. ',CR,LF,EOS
MSG_DSTKS_OFF db 'DOS Stacks sind nun inaktiv.',CR,LF,EOS
else
COMMENT|
������������������������������������������͸
�	      DOS STACKS USAGE		   �
������������������������������������������Ĵ
�					   �
�	There are __ DOS stacks each	   �
�	    of length ____ bytes.	   �
�					   �
� HW Interrupts __			   �
�		__			   �
�					   �
� The current state is .....		   �
�					   �
������������������������������������������Ĵ
�  Address  �  Status  � Stack Top � Depth �
������������������������������������������Ĵ
� ____:____ � ________ � ____:____ �   ___ �
������������������������������������������;
|

	 public  CNTBUF,CNTBUF_CNT,CNTBUF_ISIZ
	 public  CNTBUF_MPIC,CNTBUF_SPIC,CNTBUF_TAIL
	 public  CNTBUF_STATE
CNTBUF	 db	 '������������������������������������������͸',CR,LF
	 db	 '�             DOS STACKS USAGE             �',CR,LF
	 db	 '������������������������������������������Ĵ',CR,LF
	 db	 '�                                          �',CR,LF
	 db	 '�       There are  '
CNTBUF_CNT db	 '_ DOS stacks each       �',CR,LF
	 db	 '�           of length    '
CNTBUF_ISIZ db	 '_ bytes.          �',CR,LF
	 db	 '�                                          �',CR,LF
	 db	 '� HW Interrupts  '
CNTBUF_MPIC db	 '                          �',CR,LF
	 db	 '�                '
CNTBUF_SPIC db	 '                          �',CR,LF
	 db	 '�                                          �',CR,LF
	 db	 '� The current state is '
CNTBUF_STATE db  '                    �',CR,LF
	 db	 '�                                          �',CR,LF
	 db	 '������������������������������������������Ĵ',CR,LF
	 db	 '�  Address  �  Status  � Stack Top � Depth �',CR,LF
	 db	 '������������������������������������������Ĵ',CR,LF,EOS
CNTBUF_TAIL db	 '������������������������������������������;',CR,LF,EOS

	 public  CNTBUF_STATE_ON,CNTBUF_STATE_ON_LEN
CNTBUF_STATE_ON  db 'enabled. '
CNTBUF_STATE_ON_LEN equ $-CNTBUF_STATE_ON

	 public  CNTBUF_STATE_OFF,CNTBUF_STATE_OFF_LEN
CNTBUF_STATE_OFF db 'disabled.'
CNTBUF_STATE_OFF_LEN equ $-CNTBUF_STATE_OFF

	 public  MSG_DSTKS_ON,MSG_DSTKS_OFF
MSG_DSTKS_ON db  'DOS stacks are now enabled.',CR,LF,EOS
MSG_DSTKS_OFF db 'DOS stacks are now disabled.',CR,LF,EOS
endif				; IFDEF LANG_GR

DATA	 ends			; End DATA segment

	 MEND			; End UTIL_MSG module
