# I got sick of the fact that we had to check all these STIGs... AUTOMATION!!! WOOOOOO!!!
# Press Ctrl+M to collapse/expand everything.
# (Write-Banner.ps1) Shamelessly stole this cmdlet from "https://gallery.technet.microsoft.com/scriptcenter/Write-Banner-A-simple-ca6cc719". I wanted an epic banner and was to lazy to format my own. I've been using it for years.
# I got about 1400 lines of code in and I realized I needed to stop trying to optimise my code. So things are going to look rough in the development builds for a while. I just need it to work as i build.
# Hey! If I share this with you and you change it, please add a decimal point for your version. For example: v.0.3.1 is your version.
cls

# Need to resize the window, the banner gets sqooshed.
# If you run this in ISE, you will get errors. The window hidth and width don't exist during an ISE session, however the buffer does and it jacks up the ISE view. I'll clean this up some day...
$ConsoleBuffer = $Host.UI.RawUI.BufferSize
$ConsoleWindow = $Host.UI.RawUI.WindowSize
$ConsoleWindow.Height = (58)
$ConsoleWindow.Width = (138) #If this is scaled to 128, the banner meets the edge of the console window perfect... I changed this to 138 because I added a character to the banner.
$ConsoleBuffer.Height = (3000)
$ConsoleBuffer.Width = (138) #If this is scaled to 128, the banner get's deformed in ICE... I can't win here! I changed this to 138 because I added a character to the banner.
$host.UI.RawUI.set_bufferSize($ConsoleBuffer)
$host.UI.RawUI.set_windowSize($ConsoleWindow)

#Full Range Script Values (I might use this...)
$ScripVersion=0
$ScriptBuild=4

Function Write-Banner{
<#
.SYNOPSIS
Creates a banner in large letters and writes to standard output

.DESCRIPTION
Creates a banner in large letters and writes to standard output

.PARAMETER Object
Specifies text to return in banner format

.INPUTS
None.

.OUTPUTS
None.

.EXAMPLE
C:\PS> Write-Banner 'HTTP://virot.eu/'

.LINK
My Blog: http://virot.eu
Blog Entry: http://virot.eu/wordpress/the-banner-script
Source of shapes: http://ftp3.usa.openbsd.org/pub/OpenBSD/src/usr.sbin/lpr/lpd/lpdchar.c

.NOTES
Author:	Oscar Virot - virot@virot.com
Filename: Write-Banner.ps1
#>


[CmdletBinding(SupportsShouldProcess=$True)]
	Param(
		[Parameter(Mandatory=$True)]
		[String]
		[ValidateScript({if ($_.Length -gt 20) {Throw('Input to long')} else {$true}})]
		$Object,
		[Parameter(Mandatory=$False)]
		[System.ConsoleColor]
		$ForegroundColor = "DarkYellow",
		[Parameter(Mandatory=$False)]
		[System.ConsoleColor]
		$BackgroundColor = "Black"
)
Begin
	{
		$outputarray = @("","","","","","","","","")
		$Alphabet = New-Object system.collections.hashtable
		$Alphabet." " = @('        ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ')
		$Alphabet."!" = @('   !!   ',
				'   !!   ',
				'   !!   ',
				'   !!   ',
				'   !!   ',
				'        ',
				'        ',
				'   !!   ',
				'   !!   ')
		$Alphabet."""" = @('  "  "  ',
				'  "  "  ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ')
		$Alphabet."#" = @('        ',
				'   # #  ',
				'   # #  ',
				' #######',
				'   # #  ',
				' #######',
				'   # #  ',
				'   # #  ',
				'        ')
		$Alphabet."$" = @('    $   ',
				'  $$$$$ ',
				' $  $  $',
				' $  $   ',
				'  $$$$$ ',
				'    $  $',
				' $  $  $',
				'  $$$$$ ',
				'    $   ')
		$Alphabet."%" = @('  %     ',
				' % %   %',
				'  %   % ',
				'     %  ',
				'    %   ',
				'   %    ',
				'  %   % ',
				' %   % %',
				'      % ')
		$Alphabet."'" = @("    ''  ",
				"    ''  ",
				"    '   ",
				"   '    ",
				"        ",
				"        ",
				"        ",
				"        ",
				"        ");
		$Alphabet."(" = @('     (  ',
				'    (   ',
				'   (    ',
				'   (    ',
				'   (    ',
				'   (    ',
				'   (    ',
				'    (   ',
				'     (  ')
		$Alphabet.")" = @('   )    ',
				'    )   ',
				'     )  ',
				'     )  ',
				'     )  ',
				'     )  ',
				'     )  ',
				'    )   ',
				'   )    ')
		$Alphabet."*" = @('        ',
				'    *   ',
				' *  *  *',
				'  * * * ',
				'   ***  ',
				'  * * * ',
				' *  *  *',
				'    *   ',
				'        ')
		$Alphabet."+" = @('        ',
				'    +   ',
				'    +   ',
				'    +   ',
				' +++++++',
				'    +   ',
				'    +   ',
				'    +   ',
				'        ')
		$Alphabet."," = @('        ',
				'        ',
				'        ',
				'        ',
				'   ,,   ',
				'   ,,   ',
				'   ,    ',
				'  ,     ',
				'        ')
		$Alphabet."-" = @('        ',
				'        ',
				'        ',
				'        ',
				' -------',
				'        ',
				'        ',
				'        ',
				'        ')
		$Alphabet."." = @('        ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ',
				'   ..   ',
				'   ..   ')
		$Alphabet."/" = @('        ',
				'       /',
				'      / ',
				'     /  ',
				'    /   ',
				'   /    ',
				'  /     ',
				' /      ',
				'        ')
		$Alphabet."0" = @('  00000 ',
				' 0     0',
				' 0    00',
				' 0   0 0',
				' 0  0  0',
				' 0 0   0',
				' 00    0',
				' 0     0',
				'  00000 ')
		$Alphabet."1" = @('    1   ',
				'   11   ',
				'  1 1   ',
				'    1   ',
				'    1   ',
				'    1   ',
				'    1   ',
				'    1   ',
				'  11111 ')
		$Alphabet."2" = @('  22222 ',
				' 2     2',
				'       2',
				'      2 ',
				'   222  ',
				'  2     ',
				' 2      ',
				' 2      ',
				' 2222222')
		$Alphabet."3" = @('  33333 ',
				' 3     3',
				'       3',
				'       3',
				'   3333 ',
				'       3',
				'       3',
				' 3     3',
				'  33333 ')
		$Alphabet."4" = @('      4 ',
				'     44 ',
				'    4 4 ',
				'   4  4 ',
				'  4   4 ',
				' 4    4 ',
				' 4444444',
				'      4 ',
				'      4 ')
		$Alphabet."5" = @(' 5555555',
				' 5      ',
				' 5      ',
				' 55555  ',
				'      5 ',
				'       5',
				'       5',
				' 5    5 ',
				'  5555  ')
		$Alphabet."6" = @('   6666 ',
				'  6     ',
				' 6      ',
				' 6      ',
				' 6 6666 ',
				' 66    6',
				' 6     6',
				' 6     6',
				'  66666 ')
		$Alphabet."7" = @(' 7777777',
				' 7     7',
				'      7 ',
				'     7  ',
				'    7   ',
				'   7    ',
				'   7    ',
				'   7    ',
				'   7    ')
		$Alphabet."8" = @('  88888 ',
				' 8     8',
				' 8     8',
				' 8     8',
				'  88888 ',
				' 8     8',
				' 8     8',
				' 8     8',
				'  88888 ')
		$Alphabet."9" = @('  99999 ',
				' 9     9',
				' 9     9',
				' 9     9',
				'  999999',
				'       9',
				'       9',
				' 9     9',
				'  9999  ')
		$Alphabet.":" = @('        ',
				'        ',
				'        ',
				'   ::   ',
				'   ::   ',
				'        ',
				'        ',
				'   ::   ',
				'   ::   ')
		$Alphabet.";" = @('   ;;   ',
				'   ;;   ',
				'        ',
				'        ',
				'   ;;   ',
				'   ;;   ',
				'   ;    ',
				'  ;     ',
				'        ')
		$Alphabet."=" = @('        ',
				'        ',
				'        ',
				' =======',
				'        ',
				' =======',
				'        ',
				'        ',
				'        ')
		$Alphabet."?" = @('   ???? ',
				'  ?    ?',
				'  ?    ?',
				'       ?',
				'     ?? ',
				'    ?   ',
				'    ?   ',
				'        ',
				'    ?   ')
		$Alphabet."@" = @('   @@@@ ',
				'  @    @',
				' @  @@ @',
				' @ @ @ @',
				' @ @ @ @',
				' @ @@@@ ',
				' @      ',
				'  @    @',
				'   @@@@ ')
		$Alphabet."A" = @('   AAA  ',
				'  A   A ',
				' A     A',
				' A     A',
				' AAAAAAA',
				' A     A',
				' A     A',
				' A     A',
				' A     A')
		$Alphabet."B" = @(' BBBBBB ',
				'  B    B',
				'  B    B',
				'  B    B',
				'  BBBBB ',
				'  B    B',
				'  B    B',
				'  B    B',
				' BBBBBB ')
		$Alphabet."C" = @('   CCCC ',
				'  C    C',
				' C      ',
				' C      ',
				' C      ',
				' C      ',
				' C      ',
				'  C    C',
				'   CCCC ')
		$Alphabet."D" = @(' DDDDD  ',
				'  D   D ',
				'  D    D',
				'  D    D',
				'  D    D',
				'  D    D',
				'  D    D',
				'  D   D ',
				' DDDDD  ')
		$Alphabet."E" = @(' EEEEEEE',
				' E      ',
				' E      ',
				' E      ',
				' EEEEEE ',
				' E      ',
				' E      ',
				' E      ',
				' EEEEEEE')
		$Alphabet."F" = @(' FFFFFFF',
				' F      ',
				' F      ',
				' F      ',
				' FFFFFF ',
				' F      ',
				' F      ',
				' F      ',
				' F      ')
		$Alphabet."G" = @('   GGGG ',
				'  G    G',
				' G      ',
				' G      ',
				' G      ',
				' G  GGGG',
				' G     G',
				'  G    G',
				'   GGGG ')
		$Alphabet."H" = @(' H     H',
				' H     H',
				' H     H',
				' H     H',
				' HHHHHHH',
				' H     H',
				' H     H',
				' H     H',
				' H     H')
		$Alphabet."I" = @('  IIIII ',
				'    I   ',
				'    I   ',
				'    I   ',
				'    I   ',
				'    I   ',
				'    I   ',
				'    I   ',
				'  IIIII ')
		$Alphabet."J" = @('   JJJJJ',
				'     J  ',
				'     J  ',
				'     J  ',
				'     J  ',
				'     J  ',
				'     J  ',
				' J   J  ',
				'  JJJ   ')
		$Alphabet."K" = @(' K     K',
				' K    K ',
				' K   K  ',
				' K  K   ',
				' K K    ',
				' KK K   ',
				' K   K  ',
				' K    K ',
				' K     K')
		$Alphabet."L" = @(' L      ',
				' L      ',
				' L      ',
				' L      ',
				' L      ',
				' L      ',
				' L      ',
				' L      ',
				' LLLLLLL')
		$Alphabet."M" = @(' M     M',
				' MM   MM',
				' M M M M',
				' M  M  M',
				' M     M',
				' M     M',
				' M     M',
				' M     M',
				' M     M')
		$Alphabet."N" = @(' N     N',
				' NN    N',
				' N N   N',
				' N  N  N',
				' N   N N',
				' N    NN',
				' N     N',
				' N     N',
				' N     N')
		$Alphabet."O" = @('   OOO  ',
				'  O   O ',
				' O     O',
				' O     O',
				' O     O',
				' O     O',
				' O     O',
				'  O   O ',
				'   OOO  ')
		$Alphabet."P" = @(' PPPPPP ',
				' P     P',
				' P     P',
				' P     P',
				' PPPPPP ',
				' P      ',
				' P      ',
				' P      ',
				' P      ')
		$Alphabet."Q" = @('   QQQ  ',
				'  Q   Q ',
				' Q     Q',
				' Q     Q',
				' Q     Q',
				' Q  Q  Q',
				' Q   Q Q',
				'  Q   Q ',
				'   QQQ Q')
		$Alphabet."R" = @(' RRRRRR ',
				' R     R',
				' R     R',
				' R     R',
				' RRRRRR ',
				' R  R   ',
				' R   R  ',
				' R    R ',
				' R     R')
		$Alphabet."S" = @('  SSSSS ',
				' S     S',
				' S      ',
				' S      ',
				'  SSSSS ',
				'       S',
				'       S',
				' S     S',
				'  SSSSS ')
		$Alphabet."T" = @(' TTTTTTT',
				'    T   ',
				'    T   ',
				'    T   ',
				'    T   ',
				'    T   ',
				'    T   ',
				'    T   ',
				'    T   ')
		$Alphabet."U" = @(' U     U',
				' U     U',
				' U     U',
				' U     U',
				' U     U',
				' U     U',
				' U     U',
				' U     U',
				'  UUUUU ')
		$Alphabet."V" = @(' V     V',
				' V     V',
				' V     V',
				'  V   V ',
				'  V   V ',
				'   V V  ',
				'   V V  ',
				'    V   ',
				'    V   ')
		$Alphabet."W" = @(' W     W',
				' W     W',
				' W     W',
				' W     W',
				' W  W  W',
				' W  W  W',
				' W W W W',
				' WW   WW',
				' W     W')
		$Alphabet."X" = @(' X     X',
				' X     X',
				'  X   X ',
				'   X X  ',
				'    X   ',
				'   X X  ',
				'  X   X ',
				' X     X',
				' X     X')
		$Alphabet."Y" = @(' Y     Y',
				' Y     Y',
				'  Y   Y ',
				'   Y Y  ',
				'    Y   ',
				'    Y   ',
				'    Y   ',
				'    Y   ',
				'    Y   ')
		$Alphabet."Z" = @(' ZZZZZZZ',
				'       Z',
				'      Z ',
				'     Z  ',
				'    Z   ',
				'   Z    ',
				'  Z     ',
				' Z      ',
				' ZZZZZZZ')
		$Alphabet."Å" = @('   ÅÅÅ  ',
				'  Å   Å ',
				'   ÅÅÅ  ',
				'  Å   Å ',
				' Å     Å',
				' ÅÅÅÅÅÅÅ',
				' Å     Å',
				' Å     Å',
				' Å     Å')
		$Alphabet."Ä" = @(' Ä     Ä',
				'   ÄÄÄ  ',
				'  Ä   Ä ',
				' Ä     Ä',
				' Ä     Ä',
				' ÄÄÄÄÄÄÄ',
				' Ä     Ä',
				' Ä     Ä',
				' Ä     Ä')
		$Alphabet."Ö" = @(' Ö     Ö',
				'   ÖÖÖ  ',
				'  Ö   Ö ',
				' Ö     Ö',
				' Ö     Ö',
				' Ö     Ö',
				' Ö     Ö',
				'  Ö   Ö ',
				'   ÖÖÖ  ')
		$Alphabet."[" = @('  [[[[  ',
				'  [     ',
				'  [     ',
				'  [     ',
				'  [     ',
				'  [     ',
				'  [     ',
				'  [     ',
				'  [[[[  ')
		$Alphabet."\" = @('        ',
				' \      ',
				'  \     ',
				'   \    ',
				'    \   ',
				'     \  ',
				'      \ ',
				'       \',
				'        ')
		$Alphabet."]" = @('   ]]]] ',
				'      ] ',
				'      ] ',
				'      ] ',
				'      ] ',
				'      ] ',
				'      ] ',
				'      ] ',
				'   ]]]] ')
		$Alphabet." " = @('        ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ')
<#
		$Alphabet."`" = @('   ``   ',
				'   ``   ',
				'    `   ',
				'     `  ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ')
#>
		$Alphabet."a" = @('        ',
				'        ',
				'        ',
				'  aaaa  ',
				'      a ',
				'  aaaaa ',
				' a     a',
				' a    aa',
				'  aaaa a')
		$Alphabet."b" = @(' b      ',
				' b      ',
				' b      ',
				' b bbb  ',
				' bb   b ',
				' b     b',
				' b     b',
				' bb   b ',
				' b bbb  ')
		$Alphabet."c" = @('        ',
				'        ',
				'        ',
				'  cccc  ',
				' c    c ',
				' c      ',
				' c      ',
				' c    c ',
				'  cccc  ')
		$Alphabet."d" = @('      d ',
				'      d ',
				'      d ',
				'  ddd d ',
				' d   dd ',
				' d    d ',
				' d    d ',
				' d   dd ',
				'  ddd d ')
		$Alphabet."e" = @('        ',
				'        ',
				'        ',
				'  eeee  ',
				' e    e ',
				' eeeeee ',
				' e      ',
				' e    e ',
				'  eeee  ')
		$Alphabet."f" = @('    ff  ',
				'   f  f ',
				'   f    ',
				'   f    ',
				' fffff  ',
				'   f    ',
				'   f    ',
				'   f    ',
				'   f    ')
		$Alphabet."g" = @('  ggg g ',
				' g   gg ',
				' g    g ',
				' g    g ',
				' g   gg ',
				'  ggg g ',
				'      g ',
				' g    g ',
				'  gggg  ')
		$Alphabet."h" = @(' h      ',
				' h      ',
				' h      ',
				' h hhh  ',
				' hh   h ',
				' h    h ',
				' h    h ',
				' h    h ',
				' h    h ')
		$Alphabet."i" = @('        ',
				'    i   ',
				'        ',
				'   ii   ',
				'    i   ',
				'    i   ',
				'    i   ',
				'    i   ',
				'   iii  ')
		$Alphabet."j" = @('     jj ',
				'      j ',
				'      j ',
				'      j ',
				'      j ',
				'      j ',
				'      j ',
				'  j   j ',
				'   jjj  ')
		$Alphabet."k" = @(' k      ',
				' k      ',
				' k      ',
				' k   k  ',
				' k  k   ',
				' k k    ',
				' kk k   ',
				' k   k  ',
				' k    k ')
		$Alphabet."l" = @('   ll   ',
				'    l   ',
				'    l   ',
				'    l   ',
				'    l   ',
				'    l   ',
				'    l   ',
				'    l   ',
				'   lll  ')
		$Alphabet."m" = @('        ',
				'        ',
				'        ',
				' m m mm ',
				' mm m  m',
				' m  m  m',
				' m  m  m',
				' m  m  m',
				' m  m  m')
		$Alphabet."n" = @('        ',
				'        ',
				'        ',
				' n nnn  ',
				' nn   n ',
				' n    n ',
				' n    n ',
				' n    n ',
				' n    n ')
		$Alphabet."o" = @('        ',
				'        ',
				'        ',
				'  oooo  ',
				' o    o ',
				' o    o ',
				' o    o ',
				' o    o ',
				'  oooo  ')
		$Alphabet."p" = @(' p ppp  ',
				' pp   p ',
				' p    p ',
				' p    p ',
				' pp   p ',
				' p ppp  ',
				' p      ',
				' p      ',
				' p      ')
		$Alphabet."q" = @('  qqq q ',
				' q   qq ',
				' q    q ',
				' q    q ',
				' q   qq ',
				'  qqq q ',
				'      q ',
				'      q ',
				'      q ')
		$Alphabet."r" = @('        ',
				'        ',
				'        ',
				' r rrr  ',
				' rr   r ',
				' r      ',
				' r      ',
				' r      ',
				' r      ')
		$Alphabet."s" = @('        ',
				'        ',
				'        ',
				'  ssss  ',
				' s    s ',
				'  ss    ',
				'    ss  ',
				' s    s ',
				'  ssss  ')
		$Alphabet."t" = @('        ',
				'   t    ',
				'   t    ',
				' ttttt  ',
				'   t    ',
				'   t    ',
				'   t    ',
				'   t  t ',
				'    tt  ')
		$Alphabet."u" = @('        ',
				'        ',
				'        ',
				' u    u ',
				' u    u ',
				' u    u ',
				' u    u ',
				' u   uu ',
				'  uuu u ')
		$Alphabet."v" = @('        ',
				'        ',
				'        ',
				' v     v',
				' v     v',
				' v     v',
				'  v   v ',
				'   v v  ',
				'    v   ')
		$Alphabet."w" = @('        ',
				'        ',
				'        ',
				' w     w',
				' w  w  w',
				' w  w  w',
				' w  w  w',
				' w  w  w',
				'  ww ww ')
		$Alphabet."x" = @('        ',
				'        ',
				'        ',
				' x    x ',
				'  x  x  ',
				'   xx   ',
				'   xx   ',
				'  x  x  ',
				' x    x ')
		$Alphabet."y" = @(' y    y ',
				' y    y ',
				' y    y ',
				' y    y ',
				' y   yy ',
				'  yyy y ',
				'      y ',
				' y    y ',
				'  yyyy  ')
		$Alphabet."z" = @('        ',
				'        ',
				'        ',
				' zzzzzz ',
				'     z  ',
				'    z   ',
				'   z    ',
				'  z     ',
				' zzzzzz ')
		$Alphabet."}" = @('    }}  ',
				'   }    ',
				'   }    ',
				'   }    ',
				'  }     ',
				'   }    ',
				'   }    ',
				'   }    ',
				'    }}  ')
		$Alphabet."|" = @('    |   ',
				'    |   ',
				'    |   ',
				'    |   ',
				'    |   ',
				'    |   ',
				'    |   ',
				'    |   ',
				'    |   ')
		$Alphabet."}" = @('   }}   ',
				'     }  ',
				'     }  ',
				'     }  ',
				'      } ',
				'     }  ',
				'     }  ',
				'     }  ',
				'   }}   ')
		$Alphabet."~" = @('  ~~    ',
				' ~  ~  ~',
				'     ~~ ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ',
				'        ')
	}
Process
	{
		ForEach($char in $Object[0..($Object.length-1)])
		{
			if ($Alphabet[[string]$char] -ne $Null)
			{
				ForEach($i in 0..8)
				{
					$outputarray[$i] += $Alphabet[[string]$char][$i]
				}
			}
		}

		ForEach($i in 0..8)
		{
			Write-Host -Object $outputarray[$i] -Foregroundcolor:$Foregroundcolor -Backgroundcolor:$Backgroundcolor
		}
	}
} #Ok... so I need to figure out how to pass formating through the banner variable into the function. It no like the string transformation.

Write-Banner "|---------------|"
Write-Banner "| -Manual STIG- |"
Write-Banner "|Compliance Tool|"
Write-Banner "|---------------|"
Write-Host "    |Author: Shane Johnston -Systems Administrator                                                                                  |   " -ForegroundColor DarkYellow -BackgroundColor Black
Write-Host "    |Build: v0.4 (Development)                                                                              Checking current user...|   " -ForegroundColor DarkYellow -BackgroundColor Black
Write-Host "                                                            UNCLASSIFIED                                                                " -ForegroundColor Green -BackgroundColor Black
#          "____|_______________________________________________________________________________________________________________________________|___" If you want to add a line, match this length.
Sleep 3

# Writing the current user to window title. Just want to know who this session is for. For logging reasons and so the user is aware of what the script sees for their account status.
# Just had the idea to put the version in the title... It's like build 4 and I just now had the idea.... just.... wow.... I'll do it later. Maybe the host console info?
    $CurrentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $CurrentUserPrincipal = New-Object Security.Principal.WindowsPrincipal $CurrentUser
    $AdminRole = [Security.Principal.WindowsBuiltinRole]::Administrator
    If (($CurrentUserPrincipal).IsInRole($AdminRole)){$Elevated = "Administrator"}    
    
    $Title = $Elevated + " $ENV:USERNAME".ToUpper() + " - " + (Get-Date).toshortdatestring() 
    $Host.UI.RawUI.set_WindowTitle($Title)

Function Invoke-Menu {
[cmdletbinding()]
Param(
[Parameter(Position=0,Mandatory=$True)]
[ValidateNotNullOrEmpty()]
[string]$Menu = "Placeholder Menu",
[Parameter(Position=1)]
[ValidateNotNullOrEmpty()]
[string]$Title = "Placeholder Menu",
[Parameter(Position=2)]
[ValidateNotNullOrEmpty()]
[string]$Banner = "Placeholder Banner",
[Alias("cls")]
[switch]$ClearScreen
)

if ($ClearScreen) { 
 Clear-Host
}

$Menuprompt=$Banner
$Menuprompt+="`n"
$Menuprompt+="`n"
$MenuPrompt+=$Title
$Menuprompt+="`n"
$Menuprompt+="-"*$Title.Length
$Menuprompt+="`n"
$MenuPrompt+=$Menu
 
Read-Host -Prompt $Menuprompt
 
}


$LogFile="D:\MSBT Log\MSBT.log"

Function WriteTo-Log {
Param([string]$LogString)

Add-Content $LogFile -Value $LogString
}

If($CurrentUserPrincipal.IsInRole($AdminRole))
{
cls
Write-Host "Admin Access Granted: Main Menu Unlocked" -ForegroundColor Green
Write-Host " "
pause
}
Else
{
Do {
$Banner="Before continuing, this script must be elevated. Would you like to run this as an Administrator?"
$Title="Credential Check Menu"
$Menu=@"
Y - Yes
N - No
Q - Quit
"@    
    Switch (Invoke-Menu -menu $menu -title $title -banner $banner) {
        "Y" {
            $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
            Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
            Return
            } 
        "N" {
            Write-Host " "
            Write-Host "In this current build of the script, I have not put in any limited access scripts. For now, I'll ask you to leave."
            "Come visit again when you have admin rights! This window will close automatically or you can press Ctrl+C"
            sleep -Seconds 10
            Return
            }
        "Q" {
            Write-Host "Goodbye" -ForegroundColor Cyan
            Return
            }
            Default {Write-Warning "Invalid Choice. Try again."
            sleep -milliseconds 750
            }
        }
    } While ($True)
}


#Now for the script's meat and potatoes! Time to start checking for registry crap. Later I'll re-format all this into functions, later still into modules. Maybe clean it up into harder, better, faster, stronger formating.
#Note here, I will later have the script ask for the computer name before you select a STIG. That way you can run more than one STIG without having to put in the computer name for each or everytime you rerun a STIG option.
#Another Note, I want to add a return to main menu option. This is easy, I'll do it soon.
:MainMenuMaster Do {
$Banner = "The below is a list of my current manual benchmarks. Before using this unofficial tool, check DISA for up to date SCAP Benchmarks. All log information is being saved to $LogFile"
$Title = "       Main Menu       "
$Menu = @"
1 - McAfee VirusScan 8.8 Managed Client STIG :: Release: 19 Benchmark Date: 27 Jul 2018 (x64)
Q - Quit
"@    
    :MainMenu Switch (Invoke-Menu -Menu $Menu -Title $Title -Banner $Banner -Clear) {
        "1" {
            $ComputerName = Read-Host "Please input remote IP address or computername"
            Write-Host "Testing Connection..." -NoNewline
            If(Test-Connection $ComputerName -Quiet -ErrorAction SilentlyContinue)
                {
                Write-Host " Success!" -ForegroundColor Green
                Write-Host " "

                :PreCheck Do {
            $Banner="Before continuing, would you like to run a pre-check? This will change the results."
            $Title="Pre-Check Menu"
            $Menu=@"
Y - Yes
N - No
VO - View pre-check items (View Overview)
VD - View pre-check items (View Details)
Q - Quit
"@
                    Switch (Invoke-Menu -menu $menu -title $title -banner $banner -Clear) {
                        "Y" {
                        cls
                        #COLERS!!! THEY BROKE! IDK WHY!!!!
                        Write-Host "----- Pre-Check Results -----"
                        Write-Host "Checking for Outlook: " -NoNewline
                        $Key='SOFTWARE\Classes\Outlook.Application'
                        $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                        $RegKey=$Reg.opensubkey($Key)
                        If($RegKey)
                            {
                            $OutlookInstalled=$True
                            Write-Host "Installed." -ForegroundColor Gray
                            break PreCheck
                            }
                            Else
                            {
                            $OutlookInstalled=$False
                            Write-Host "Not Installed." -ForegroundColor Gray
                            break PreCheck
                            }
                        } 
                        "N" {
                        cls
                        Write-Host "User elected to not run the pre-check." -ForegroundColor Gray
                        break PreCheck
                        }
                        "VO" {
                        Write-Host " "
                        Write-Host "- Outlook: Checks if Outlook is installed"
                        Write-Host " "
                        pause
                        }
                        "VD" {
                        # I don't like how I'm using all these write host cmdlets. I want to format a list or something at somepoint.
                        Write-Host " "
                        Write-Host "- Outlook: Checks if Outlook is installed. Changes the results of the following to N/A:"
                        Write-Host "   - V-6586"
                        Write-Host "   - V-6587"
                        Write-Host "   - V-6588"
                        Write-Host "   - V-6590"
                        Write-Host "   - V-6591"
                        Write-Host "   - V-6592"
                        Write-Host "   - V-6596"
                        Write-Host "   - V-6597"
                        Write-host " "
                        pause
                        }
                        "Q" {Write-Host "Goodbye" -ForegroundColor Cyan
                        Return
                        }
                        Default {Write-Warning "Invalid Choice. Try again."
                        sleep -milliseconds 750
                        }
                    }
                } While ($True)

                Write-Host " "
                Write-Host "----- Vul ID Results -----"
# --------------Begin Remote Registry Checks
# A note here, if the key value does not exist than it will throw a null-valued expression operation error. I'll change this later.
                Write-Host "Checking Vul ID: V-6453... " -NoNewline
                $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\On Access Scanner\McShield\Configuration'
                $Value='bStartDisabled'
                $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                $RegKey=$Reg.opensubkey($Key)
                If($RegKey.getvalue($Value) -eq 0)
                    {
                    Write-Host "STIG Compliant " -ForegroundColor Green
                    }
                    Else
                    {
                    Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                    Write-Host "- Value is not set to 0. Review STIG Check text."
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6467... " -NoNewline
                $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\On Access Scanner\McShield\Configuration'
                $Value='bDontScanBootSectors'
                $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                $RegKey=$Reg.opensubkey($Key)
                If($RegKey.getvalue($Value) -eq 0)
                    {
                    Write-Host "STIG Compliant " -ForegroundColor Green
                    }
                    Else
                    {
                    Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                    Write-Host "- Value is not set to 0. Review STIG Check text."
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6468... " -NoNewline
                $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\On Access Scanner\McShield\Configuration'
                $Value='bScanFloppyonShutdown'
                $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                $RegKey=$Reg.opensubkey($Key)
                If($RegKey.getvalue($Value) -eq 1)
                    {
                    Write-Host "STIG Compliant " -ForegroundColor Green
                    }
                    Else
                    {
                    Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                    Write-Host "- Value is not set to 1. Review STIG Check text."
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6469... " -NoNewline
                $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\On Access Scanner\McShield\Configuration'
                $Value='Alert_AutoShowList'
                $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                $RegKey=$Reg.opensubkey($Key)
                If($RegKey.getvalue($Value) -eq 1)
                    {
                    Write-Host "STIG Compliant " -ForegroundColor Green
                    }
                    Else
                    {
                    Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                    Write-Host "- Value is not set to 1. Review STIG Check text."
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6470... " -NoNewline
                $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\On Access Scanner\McShield\Configuration'
                $Value='Alert_UsersCanRemove'
                $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                $RegKey=$Reg.opensubkey($Key)
                If($RegKey.getvalue($Value) -eq 0)
                    {
                    Write-Host "STIG Compliant " -ForegroundColor Green
                    }
                    Else
                    {
                    Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                    Write-Host "- Value is not set to 0. Review STIG Check text."
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6474... " -NoNewline
                $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\On Access Scanner\McShield\Configuration'
                $Value='bLogtoFile'
                $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                $RegKey=$Reg.opensubkey($Key)
                If($RegKey.getvalue($Value) -eq 1)
                    {
                    Write-Host "STIG Compliant " -ForegroundColor Green
                    }
                    Else
                    {
                    Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                    Write-Host "- Value is not set to 1. Review STIG Check text."
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6475... " -NoNewline
                $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\On Access Scanner\McShield\Configuration'
                $Value1='bLimitSize'
                $Value2='dwMaxLogSizeMB'
                $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                $RegKey=$Reg.opensubkey($Key)
                If(($RegKey.getvalue($Value1) -eq 1) -and ($RegKey.getvalue($Value2) -ge 10))
                    {
                    Write-Host "STIG Compliant " -ForegroundColor Green
                    }
                    Else
                    {
                    Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                    Write-Host "- Value is not set to 1 and/or secondary value is not greater than or equal to 10. Review STIG Check text."
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6478... " -NoNewline
                $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\On Access Scanner\McShield\Configuration'
                $Value='bLogSummary'
                $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                $RegKey=$Reg.opensubkey($Key)
                If($RegKey.getvalue($Value) -eq 1)
                    {
                    Write-Host "STIG Compliant " -ForegroundColor Green
                    }
                    Else
                    {
                    Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                    Write-Host "- Value is not set to 1. Review STIG Check text."
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6583... " -NoNewline
                $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\On Access Scanner\McShield\Configuration'
                $Value='ReportEncryptedFiles'
                $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                $RegKey=$Reg.opensubkey($Key)
                If($RegKey.getvalue($Value) -eq 1)
                    {
                    Write-Host "STIG Compliant " -ForegroundColor Green
                    }
                    Else
                    {
                    Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                    Write-Host "- Value is not set to 1. Review STIG Check text."
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6585... " -NoNewline
                $TPath=Test-Path -Path "\\$ComputerName\C$\ProgramData\McAfee\Common Framework\Task"
                If($TPath -eq $True)
                    {
                    Write-Host "Manual Check Required " -ForegroundColor Yellow -NoNewline
                    Write-Host "- Folder does exist. Verify .ini configuration against STIG Check text."
                    }
                    Else
                    {
                    $Key='SOFTWARE\Wow6432Node\McAfee\DesktopProtection\Tasks'
                    $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                    $RegKey=$Reg.opensubkey($Key)
                    If($RegKey)
                        {
                        Write-Host "Manual Check Required " -ForegroundColor Yellow -NoNewline
                        Write-Host "- Folder does not exist. Registry key exists. Verify with ePO server owner the Check/Fix text."
                        }
                        Else
                        {
                        Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                        Write-Host "- Both folder and registry key do not exist. Verify with ePO server owner the Check/Fix text."
                        }
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6586... " -NoNewline
                If($OutlookInstalled -eq $True)
                    {
                    $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\Email Scanner\Outlook\OnDelivery\GeneralOptions'
                    $Value='bEnabled'
                    $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                    $RegKey=$Reg.opensubkey($Key)
                    If($RegKey.getvalue($Value) -eq 1)
                        {
                        Write-Host "STIG Compliant " -ForegroundColor Green
                        }
                        Else
                        {
                        Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                        Write-Host "- Value is not set to 1. Review STIG Check text."
                        }
                    }
                    Else
                    {
                    Write-Host "N/A" -ForegroundColor Gray
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6587... " -NoNewline
                If($OutlookInstalled -eq $True)
                    {
                    $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\Email Scanner\Outlook\OnDelivery\DetectionOptions'
                    $Value='dwProgramHeuristicsLevel'
                    $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                    $RegKey=$Reg.opensubkey($Key)
                    If($RegKey.getvalue($Value) -eq 1)
                        {
                        Write-Host "STIG Compliant " -ForegroundColor Green
                        }
                        Else
                        {
                        Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                        Write-Host "- Value is not set to 1. Review STIG Check text."
                        }
                    }
                    Else
                    {
                    Write-Host "N/A" -ForegroundColor Gray
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6588... " -NoNewline
                If($OutlookInstalled -eq $True)
                    {
                    $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\Email Scanner\Outlook\OnDelivery\DetectionOptions'
                    $Value='dwMacroHeuristicsLevel'
                    $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                    $RegKey=$Reg.opensubkey($Key)
                    If($RegKey.getvalue($Value) -eq 1)
                        {
                        Write-Host "STIG Compliant " -ForegroundColor Green
                        }
                        Else
                        {
                        Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                        Write-Host "- Value is not set to 1. Review STIG Check text."
                        }
                    }
                    Else
                    {
                    Write-Host "N/A" -ForegroundColor Gray
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6590... " -NoNewline
                If($OutlookInstalled -eq $True)
                    {
                    $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\Email Scanner\Outlook\OnDelivery\DetectionOptions'
                    $Value='ScanMime'
                    $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                    $RegKey=$Reg.opensubkey($Key)
                    If($RegKey.getvalue($Value) -eq 1)
                        {
                        Write-Host "STIG Compliant " -ForegroundColor Green
                        }
                        Else
                        {
                        Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                        Write-Host "- Value is not set to 1. Review STIG Check text."
                        }
                    }
                    Else
                    {
                    Write-Host "N/A" -ForegroundColor Gray
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6592... " -NoNewline
                If($OutlookInstalled -eq $True)
                    {
                    $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\Email Scanner\Outlook\OnDelivery\ActionOptions'
                    $Value='uAction'
                    $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                    $RegKey=$Reg.opensubkey($Key)
                    If($RegKey.getvalue($Value) -eq 5)
                        {
                        Write-Host "STIG Compliant " -ForegroundColor Green
                        }
                        Else
                        {
                        Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                        Write-Host "- Value is not set to 5. Review STIG Check text."
                        }
                    }
                    Else
                    {
                    Write-Host "N/A" -ForegroundColor Gray
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6596... " -NoNewline
                If($OutlookInstalled -eq $True)
                    {
                    $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\Email Scanner\Outlook\OnDelivery\ReportOptions'
                    $Value='bLogToFile'
                    $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                    $RegKey=$Reg.opensubkey($Key)
                    If($RegKey.getvalue($Value) -eq 1)
                        {
                        Write-Host "STIG Compliant " -ForegroundColor Green
                        }
                        Else
                        {
                        Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                        Write-Host "- Value is not set to 1. Review STIG Check text."
                        }
                    }
                    Else
                    {
                    Write-Host "N/A" -ForegroundColor Gray
                    }
# ------------------End of Vul ID check
                Write-Host "Checking Vul ID: V-6596... " -NoNewline
                If($OutlookInstalled -eq $True)
                    {
                    $Key='SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\Email Scanner\Outlook\OnDelivery\ReportOptions'
                    $Value1='bLimitSize'
                    $Reg=[Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $ComputerName)
                    $RegKey=$Reg.opensubkey($Key)
                    If(($RegKey.getvalue($Value1) -eq 1) -and ($RegKey.GetValue($Value2) -le 10))
                        {
                        Write-Host "STIG Compliant " -ForegroundColor Green
                        }
                        Else
                        {
                        Write-Host "Not STIG Compliant " -ForegroundColor Red -NoNewline
                        Write-Host "- Value is not set to 1 and/or secondary value is not greater than or equal to 10. Review STIG Check text."
                        }
                    }
                    Else
                    {
                    Write-Host "N/A" -ForegroundColor Gray
                    }
# ------------------End of Vul ID check

                Write-Host " "
                Write-Host "Warning! pressing continue will close this information. This will change with newer versions of the tool" -ForegroundColor DarkYellow
                Pause
                }
            Else
                {
                Write-Host "Failure!" -ForegroundColor Red
                Write-Host "$ComputerName is dead or does not exist. Verify your spelling and try again."
                Pause
                }
            } 
        "Q" {Write-Host "Goodbye" -ForegroundColor Cyan
            Return
            }
            Default {Write-Warning "Invalid Choice. Try again."
            sleep -milliseconds 750
            }
        }
    } While ($True)
cls
Write-Host "Whoops! Somehow you slipped through all my script!" -ForegroundColor DarkRed
Write-Host "If you see this, than the script was modified." -ForegroundColor Gray
Write-Host "Please reach out to whoever changed it so they can change it back. You can also reach out to the author:" -ForegroundColor Gray
Write-Host "Shane Johnston: shaneandrewjohnston@gmail.com" -ForegroundColor Gray
pause
exit

<#
Changelog
v0.1
- Write-Banner Function Totally STOLEN and checked for functional integrity.
- Banner built, Titled: "Manuel STIG Benchmark Tool".

v0.2
- Customized banner to add border and "-".
- Invoke-Menu Function created.
- Built "Security Check Menu" Menu.
- Built "Main Menu" Menu.
- Built credential check and self-elevation script block.

v0.3
- WriteTo-Log Function created.
- Remote registry check scriptblocks built and tested for the following:
    V-6453
    V-6467
    V-6468
    V-6469
    V-6470
    V-6474
    V-6475
    V-6478
    V-6583
    V-6585

v0.4
- Built "Pre-Check Menu" Menu 
- Created Outlook Precheck
- Remote registry check scriptblocks built and tested for the following:
    V-6586
    V-6587
    V-6588
    V-6590
    V-6591
    V-6592
    V-6596
    V-6597

#>
