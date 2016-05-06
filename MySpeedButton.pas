unit MySpeedButton;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons;

type
  TMySpeedButton = class(TSpeedButton)
  Private
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    procedure cmmouseenter(var msg: TMessage); Message CM_MOUSEENTER;
    procedure cmmouseleave(var msg: tmessage); Message cm_mouseleave;
  Published
    property OnMouseEnter: TNotifyEvent Read FOnMouseEnter Write FOnMouseEnter;
    property OnMouseLeave: TnotifyEvent Read FOnMouseLeave Write FOnMouseLeave;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('ActiveX', [TMySpeedButton]);
end;

{ TMySpeedButton }

procedure TMySpeedButton.cmmouseenter(var msg: TMessage);
begin
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(self);
  inherited;
end;

procedure TMySpeedButton.cmmouseleave(var msg: tmessage);
begin
  if Assigned(FOnMouseEnter) then
    FOnMouseLeave(self);
  inherited;
end;

end.
