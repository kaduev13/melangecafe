unit Measures;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Measure;

type
	TfmMeasures = class(TForm)
		sgMeasures: TStringGrid;
		pnlBtns: TPanel;
		btnEdit: TButton;
		btnCreate: TButton;
		btnDelete: TButton;
    procedure btnCreateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
	private
		items: TMeasureArray;
		BaseName: string;
		procedure resetItems();
	public
    	procedure prepare();
end;

procedure show(ABaseName: string);

var
	fmMeasures: TfmMeasures;

implementation

{$R *.dfm}

uses
	MeasureRepository, MeasureCard;

procedure show(ABaseName: string);
begin
	if (fmMeasures = nil) then
	begin
		fmMeasures := TfmMeasures.Create(nil);
	end;
	fmMeasures.BaseName := ABaseName;
	fmMeasures.prepare();
	fmMeasures.Show();
end;

{ TfmMeasures }

procedure TfmMeasures.btnCreateClick(Sender: TObject);
var
	Measure: TMeasure;
begin
	Measure := TMeasure.Create();
	if (MeasureCard.show(@Measure)) then
	begin
		Measure.Insert(BaseName);
		resetItems();
	end;
end;

procedure TfmMeasures.btnDeleteClick(Sender: TObject);
var
	selected: integer;
begin
	selected := sgMeasures.Selection.Top;
	if (selected > 0) and (length(items) >= selected) then
	begin
		items[selected - 1].Delete(BaseName);
		resetItems();
    end;
end;

procedure TfmMeasures.btnEditClick(Sender: TObject);
var
	selected: integer;
begin
	selected := sgMeasures.Selection.Top;
	if (selected > 0) and (length(items) >= selected) then
	begin
		if (MeasureCard.show(@items[selected - 1])) then
		begin
			items[selected - 1].Update(BaseName);
			resetItems();
        end;
    end;
end;

procedure TfmMeasures.prepare;
begin
	with sgMeasures do
	begin
		ColCount := 2;
		RowCount := 1;
		FixedCols := 1;
		Cells[0, 0] := 'Id';
		Cells[1, 0] := 'Название';
		ColWidths[0] := 100;
		ColWidths[1] := 300;
	end;
	resetItems();
end;

procedure TfmMeasures.resetItems;
var
	i: integer;
begin
	sgMeasures.RowCount := 1;
	for i := 0 to high(items) do
	begin
		FreeAndNil(items[i]);
	end;
	setlength(items, 0);
	items := TMeasureRepository.GetAll(BaseName);
	for i := 0 to high(items) do
	begin
		with sgMeasures do
		begin
			RowCount := RowCount + 1;
			Cells[0, i + 1] := IntToStr(items[i].Id);
			Cells[1, i + 1] := items[i].Caption;
        end;
	end;
end;

end.
