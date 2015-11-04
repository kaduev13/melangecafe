unit SessionPicker;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, SessionRepository, Session;

type
	TfmSessionPicker = class(TForm)
		sgSession: TStringGrid;
    procedure sgSessionClick(Sender: TObject);
	private
		BaseName: string;
		Sessions: TSessionArray;
	{ Private declarations }
	public
		SelectedIdx: integer;
		procedure prepare(ABaseName: string);
	end;

var
	fmSessionPicker: TfmSessionPicker;

function show(ABaseName: string): boolean;

function selectSession(ABaseName: string): TSession;

implementation

{$R *.dfm}

function show(ABaseName: string): boolean;
begin
	if (fmSessionPicker = nil) then
	begin
        fmSessionPicker := TfmSessionPicker.Create(nil);
	end;
	fmSessionPicker.prepare(ABaseName);
	fmSessionPicker.ShowModal();
	result := fmSessionPicker.ModalResult = mrOk;
end;

function selectSession(ABaseName: string): TSession;
begin
	if (show(ABaseName)) then
	begin
        result := fmSessionPicker.Sessions[fmSessionPicker.SelectedIdx];
	end
	else
	begin
        result := nil;
    end;

end;

{ TfmSessionPicker }

procedure TfmSessionPicker.prepare(ABaseName: string);
var
	i: integer;
begin
	BaseName := ABaseName;
	for i := 0 to high(Sessions) do
	begin
        FreeAndNil(Sessions[i]);
	end;
	setlength(Sessions, 0);
	with sgSession do
	begin
		RowCount := 1;
		ColCount := 3;
		Cells[0, 0] := 'Id';
		Cells[1, 0] := '��������';
		Cells[2, 0] := '�����������';
		ColWidths[0] := 30;
		ColWidths[1] := 150;
		ColWidths[2] := 150;
    end;

	Sessions := TSessionRepository.GetAll(ABaseName);

	for i := 0 to high(Sessions) do
	begin
		sgSession.RowCount := sgSession.RowCount + 1;
		sgSession.Cells[0, i + 1] := IntToStr(Sessions[i].Id);
		sgSession.Cells[1, i + 1] := DateTimeToStr(Sessions[i].DtStart);
		if (Sessions[i].DtEnd = 0) then
			sgSession.Cells[2, i + 1] := '�� ���������'
		else
			sgSession.Cells[2, i + 1] := DateTimeToStr(Sessions[i].DtEnd);
    end;
end;

procedure TfmSessionPicker.sgSessionClick(Sender: TObject);
begin
	if (sgSession.Selection.Top = 0) then
		exit;
	SelectedIdx := sgSession.Selection.Top - 1;
	ModalResult := mrOk;
	CloseModal;
//	Close;
end;

end.
