unit Lan;

interface

uses
  inifiles, sysutils,classes,Forms,controls,stdctrls,extctrls,menus,ActnList,dialogs;

var
  ss_msg: array[0..22] of string;

procedure SetLanguage(const FileName: string; var msg: array of string; const IgnoreTagValue: byte = $FF);

implementation

{****************************************
*      模块说明：利用切换INI切换语言函数*
*          作者：Kingron@163.net        *
****************************************}
{****************************************
  下面的编译指定表示是否导出成一个INI文件
  一般的情况下面，没有必要修改，但需要母本
  INI的时候，可以把注释去掉
****************************************}
{$IFNDEF INI_EXPORT}
///{$DEFINE INI_EXPORT}
{$ENDIF}
{****************************************
  函数参数说明：
    FileName:Ini语言文件名
    msg:用于程序中的信息的保存数组
    IgnoreTagValue:需要忽略的组件的Tag值
  使用举例：
    var
      Msg:array of string;
    .....
    SetLanguage(ExtractFilePath(ParamStr(0))+'English.Ini',msg,$FF);
    那么函数会忽略所有Tag值为$FF的控件
****************************************}

procedure SetLanguage(const FileName: string; var msg: array of string; const IgnoreTagValue: byte = $FF);
const
  ///下面是一些常量
  TRANS_SECTION     = 'Translations';
  MESSAGES          = 'Messages';
  COMMON            = 'Common';
  HINT              = 'Hint';
  CAPTION           = 'Caption';
  MSG_PRE           = 'SS_Msg_';
var
  i, j, k           : integer;
  Component         : TComponent;
  Control           : TControl;
  Strings           : TStrings;
  Id                : string;
  OldCaption        : pchar;
  L                 : integer;
begin
  with TIniFile.Create(FileName) do
  try
{$IFDEF INI_EXPORT}
    if Application.Title<>'' then  WriteString(COMMON, 'Application.Title', Application.Title);
    WriteBool(COMMON, 'CheckValid', True);
{$ELSE}
    if not ReadBool(COMMON, 'CheckValid', False) then exit; ///不是合法的语言文件
    Application.Title := ReadString(COMMON, 'Application.Title', Application.Title);
{$ENDIF}
    for i := Low(msg) to High(msg) do ///读取非控件的一些语言元素
{$IFDEF INI_EXPORT}
      if Msg[i]<>'' then
        WriteString(MESSAGES, MSG_PRE + IntToStr(i), msg[i]);
{$ELSE}
      msg[i] := ReadString(MESSAGES, MSG_PRE + IntToStr(i), msg[i]);
{$ENDIF}
    for i := 0 to Screen.FormCount - 1 do ///遍历程序所有窗体
    begin
{$IFDEF INI_EXPORT}
      if Screen.Forms[i].Caption<>'' then
        WriteString(TRANS_SECTION, Screen.Forms[i].Name + '.' + CAPTION, Screen.Forms[i].Caption);
      if Screen.Forms[i].Hint<>'' then
        WriteString(TRANS_SECTION, Screen.Forms[i].Name + '.' + HINT, Screen.Forms[i].Hint);
{$ELSE}
      Screen.Forms[i].Caption := ReadString(TRANS_SECTION, Screen.Forms[i].Name + '.' + CAPTION, Screen.Forms[i].Caption);
      Screen.Forms[i].Hint := ReadString(TRANS_SECTION, Screen.Forms[i].Name + '.' + HINT, Screen.Forms[i].Hint);
{$ENDIF}
      for j := 0 to Screen.Forms[i].ComponentCount - 1 do ///遍历窗体所有组件
      begin
        Component := Screen.Forms[i].Components[j] as TComponent;
        if Component.Tag = IgnoreTagValue then Continue; ///需要忽略的控件
        Id := Screen.Forms[i].Name + '.' + Component.Name + '.';
        if Component is TControl then ///普通的控件如：TButton,TSpeedButton,TBitBtn,TCheckBox....
        begin
          Control := Component as TControl;
/// 下面的代码是用来生成第一个INI文件使用的
{$IFDEF INI_EXPORT}
          if Control.Hint<>'' then
            WriteString(TRANS_SECTION, Id + HINT, Control.Hint);
{$ELSE}
          Control.Hint := ReadString(TRANS_SECTION, Id + HINT, Control.Hint);
{$ENDIF}
          if Control is TCustomEdit then Continue; ///忽略TMemo,TEdit之类的
          if (Component is TCustomListBox) or (Component is TCustomRadioGroup)
            or (Component is TCustomComboBox) then /// Listbox,RadioGroup,Combobox必须单独处理
          begin
            Strings := nil; ///本行用于忽略编译信息
            if Component is TCustomListBox then Strings := TCustomListBox(Component).Items;
            if Component is TCustomRadioGroup then Strings := TRadioGroup(Component).Items;
            if Component is TCustomComboBox then Strings := TCustomComboBox(Component).Items;
            for k := 0 to Strings.Count - 1 do ///遍历Items的每一项
{$IFDEF INI_EXPORT}
              WriteString(TRANS_SECTION, ID + 'Items.' + IntToStr(k), Strings.Strings[k]);
{$ELSE}
              Strings.Strings[k] := ReadString(TRANS_SECTION, ID + 'Items.' + IntToStr(k), Strings.Strings[k]);
{$ENDIF}
          end;
          if Component is TCustomComboBox then Continue; ///Combobox还有一点儿问题，:-(
          L := Control.GetTextLen + 1;
          GetMem(OldCaption, L);
          Control.GetTextBuf(OldCaption, L);
{$IFDEF INI_EXPORT}
          if StrPas(OldCaption)<>'' then
            WriteString(TRANS_SECTION, Id + CAPTION, OldCaption);
{$ELSE}
          Control.SetTextBuf(pchar(ReadString(TRANS_SECTION, Id + CAPTION, OldCaption)));
{$ENDIF}
          FreeMem(OldCaption, L);
          continue;
        end;
        if Component is TMenuItem then /// 处理TMenuItem
        begin
{$IFDEF INI_EXPORT}
          if (TMenuItem(Component).Caption<>'') and (TMenuItem(Component).Caption <>'-') then
            WriteString(TRANS_SECTION, Id + CAPTION, TMenuItem(Component).Caption);
          if TMenuItem(Component).Hint<>'' then
            WriteString(TRANS_SECTION, Id + HINT, TMenuItem(Component).Hint);
{$ELSE}
          TMenuItem(Component).Caption := ReadString(TRANS_SECTION, ID + CAPTION, TMenuItem(Component).Caption);
          TMenuItem(Component).Hint := ReadString(TRANS_SECTION, ID + HINT, TMenuItem(Component).Hint);
{$ENDIF}
          Continue;
        end;
        if Component is TCustomAction then /// 处理TAction
        begin
{$IFDEF INI_EXPORT}
          if TCustomAction(Component).Caption<>'' then
            WriteString(TRANS_SECTION, Id + CAPTION, TCustomAction(Component).Caption);
          if TCustomAction(Component).Hint<>'' then
            WriteString(TRANS_SECTION, Id + HINT, TCustomAction(Component).Hint);
{$ELSE}
          TCustomAction(Component).Caption := ReadString(TRANS_SECTION, CAPTION, TCustomAction(Component).Caption);
          TCustomAction(Component).Hint := ReadString(TRANS_SECTION, ID + HINT, TCustomAction(Component).Hint);
{$ENDIF}
          Continue;
        end;
        if Component is TOpenDialog then  ///处理TOpenDialog,TSaveDialog,....
        begin
{$IFDEF INI_EXPORT}
          if TOpenDialog(Component).Filter<>'' then
            WriteString(TRANS_SECTION, Id + 'Filter', TOpenDialog(Component).Filter);
          if TOpenDialog(Component).Title<>'' then
            WriteString(TRANS_SECTION, Id + 'Title', TOpenDialog(Component).Title);
{$ELSE}
          TOpenDialog(Component).Filter := ReadString(TRANS_SECTION, ID + HINT, TOpenDialog(Component).Filter);
          TOpenDialog(Component).Title := ReadString(TRANS_SECTION, CAPTION, TOpenDialog(Component).Title);
{$ENDIF}
        end;
      end;
    end;
  finally
    Free;
  end;
end;

end.

