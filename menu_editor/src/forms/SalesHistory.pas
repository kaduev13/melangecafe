unit SalesHistory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.ComCtrls, PricedGood, Vcl.CheckLst, Good, Session;

type
	TfmSalesHistory = class(TForm)
	dtpStart: TDateTimePicker;
    pnlFilters: TPanel;
    dtpEnd: TDateTimePicker;
    sgHistory: TStringGrid;
    btnGoodFilters: TButton;
    pnlGoodFilters: TPanel;
    clGoods: TCheckListBox;
    pnlResults: TPanel;
    sgResults: TStringGrid;
    btnXLExport: TButton;
    btnStart: TButton;
    btnSessStart: TButton;
    btnSessEnd: TButton;
    dtpStartTime: TDateTimePicker;
    dtpEndTime: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    pnlGoodAdditionalFilters: TPanel;
    cbBar: TCheckBox;
    cbKitchen: TCheckBox;
	procedure btnStartClick(Sender: TObject);
	procedure btnGoodFiltersClick(Sender: TObject);
    procedure btnXLExportClick(Sender: TObject);
    procedure btnSessStartClick(Sender: TObject);
	procedure btnSessEndClick(Sender: TObject);
    procedure cbBarClick(Sender: TObject);
	public
		goods: THistoryPricedGoodArray;
		goodsFilters: TGoodArray;
		BaseName: string;
		procedure prepare();
		procedure prepareFilters();
		procedure resetItems();
	end;

procedure show(ABaseName: string);

var
	fmSalesHistory: TfmSalesHistory;

implementation

uses
	PricedGoodRepository, GoodRepository, vars, ComObj, SessionPicker;

{$R *.dfm}

procedure show(ABaseName: string);
begin
	if (fmSalesHistory = nil) then
	begin
        fmSalesHistory := TfmSalesHistory.Create(nil);
	end;
	fmSalesHistory.BaseName := ABaseName;
	fmSalesHistory.prepare();
	fmSalesHistory.Show();
end;

{ TfmSalesHistory }

procedure TfmSalesHistory.btnGoodFiltersClick(Sender: TObject);
begin
	if pnlGoodFilters.Visible then
	begin
		btnGoodFilters.Caption := '������';
		dtpStart.Enabled := true;
		dtpEnd.Enabled := true;
		dtpStartTime.Enabled := true;
		dtpEndTime.Enabled := true;
		btnStart.Enabled := true;
		btnXLExport.Enabled := true;
		resetItems();
	end
	else
	begin
		btnGoodFilters.Caption := '���������';
		dtpStart.Enabled := false;
		dtpEnd.Enabled := false;
		dtpStartTime.Enabled := false;
		dtpEndTime.Enabled := false;
		btnStart.Enabled := false;
		btnXLExport.Enabled := false;
	end;
	pnlGoodFilters.Visible := not pnlGoodFilters.Visible;
end;

procedure TfmSalesHistory.btnSessEndClick(Sender: TObject);
var
	sess: TSession;
	btnSelected: integer;
begin
	sess := SessionPicker.selectSession(BaseName);
	if (sess = nil) then
	begin
		exit;
	end;
	if (sess.DtEnd = 0) then
	begin
		btnSelected := MessageDlg(
			'��������� ������ �� ���� ���������! ������� ���� ������ ���� ������?',
			mtConfirmation,
			mbOKCancel,
			0
		);
		if (btnSelected = mrOK) then
		begin
			dtpEnd.Date := Int(sess.DtStart);
			dtpEndTime.Time := Frac(sess.DtStart);
        end;
	end
	else
	begin
		dtpEnd.Date := Int(sess.DtEnd);
		dtpEndTime.Time := Frac(sess.DtEnd);
    end;
end;

procedure TfmSalesHistory.btnSessStartClick(Sender: TObject);
var
	sess: TSession;
begin
	sess := SessionPicker.selectSession(BaseName);
	if (sess = nil) then
	begin
		exit;
	end;
	dtpStart.Date := Int(sess.DtStart);
	dtpStartTime.Time := Frac(sess.DtStart);
end;

procedure TfmSalesHistory.btnStartClick(Sender: TObject);
begin
	resetItems();
end;

procedure TfmSalesHistory.btnXLExportClick(Sender: TObject);
var
  xls, wb, Range: OLEVariant;
  arrData: Variant;
  RowCount, ColCount, i, j: Integer;
begin
  {create variant array where we'll copy our data}
  RowCount := sgHistory.RowCount;
  ColCount := sgHistory.ColCount;
  arrData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);

  {fill array}
  for i := 1 to RowCount do
    for j := 1 to ColCount do
      arrData[i, j] := sgHistory.Cells[j-1, i-1];

  {initialize an instance of Excel}
  xls := CreateOLEObject('Excel.Application');

  {create workbook}
  wb := xls.Workbooks.Add;

  {retrieve a range where data must be placed}
  Range := wb.WorkSheets[1].Range[wb.WorkSheets[1].Cells[1, 1],
                                  wb.WorkSheets[1].Cells[RowCount, ColCount]];

  {copy data from allocated variant array}
  Range.Value := arrData;

  {show Excel with our data}
  xls.Visible := True;
end;

procedure TfmSalesHistory.cbBarClick(Sender: TObject);
begin
	prepareFilters();
end;

procedure TfmSalesHistory.prepare;
var
	i: integer;
begin
	with sgHistory do
	begin
		RowCount := 1;
		ColCount := 6;
		FixedCols := 1;
		Cells[0, 0] := 'Id';
		Cells[1, 0] := '��������';
		Cells[2, 0] := '����';
		Cells[3, 0] := '���-��';
		Cells[4, 0] := '�� �����';
		Cells[5, 0] := '�� ������';
		ColWidths[0] := 50;
		ColWidths[1] := 250;
		ColWidths[2] := 70;
		ColWidths[3] := 100;
		ColWidths[4] := 100;
		ColWidths[5] := 100;
	end;
	with sgResults do
	begin
		RowCount := 5;
		ColCount := 3;
		FixedCols := 1;
		FixedRows := 1;
		Cells[1, 0] := '���-��, ��.';
		Cells[2, 0] := '�������';
		Cells[0, 1] := '������� �������';
		Cells[0, 2] := '�� �����';
		Cells[0, 3] := '�� �������';
		Cells[0, 4] := '�����';
		ColWidths[0] := 200;
		ColWidths[1] := 150;
		ColWidths[2] := 150;
	end;
	prepareFilters();
end;

procedure TfmSalesHistory.prepareFilters();
var i: integer;
	allGoods: TGoodArray;
	cats: array [0..1] of boolean;
begin
	cats[0] := cbBar.Checked;
	cats[1] := cbKitchen.Checked;
	for i := 0 to high(goodsFilters) do
	begin
		FreeAndNil(goodsFilters[i]);
	end;
	setlength(goodsFilters, 0);
	allGoods := TGoodRepository.GetAllWithoutCheck(BaseName);
	clGoods.Items.Clear;
	for i := 0 to high(allGoods) do
	begin
		if (cats[allGoods[i].Flag - 1]) then
		begin
			setlength(goodsFilters, length(goodsFilters) + 1);
			goodsFilters[high(goodsFilters)] := allGoods[i].Copy();
			clGoods.Items.Add(goodsFilters[high(goodsFilters)].Caption);
		end;
		FreeAndNil(allGoods[i]);
	end;
	setlength(allGoods, 0);
   	clGoods.CheckAll(cbChecked);

end;

procedure TfmSalesHistory.resetItems;
var
	i: integer;
	checked: array of integer;
	cnts: array [0..3] of double;
	sums: array [0..3] of double;
	dtStart, dtEnd: TDateTime;
begin
	for i := 0 to 3 do
	begin
		cnts[i] := 0;
		sums[i] := 0;
    end;
	for i := 0 to high(goods) do
	begin
        FreeAndNil(goods[i]);
    end;
	sgHistory.RowCount := 1;
	setlength(checked, 0);
	for i := 0 to clGoods.Items.Count - 1 do
	begin
		if clGoods.Checked[i] then
		begin
			setlength(checked, length(checked) + 1);
			checked[high(checked)] := goodsFilters[i].Id;
        end;
	end;
	dtStart := Int(dtpStart.Date) + Frac(dtpStartTime.Time);
	dtEnd := Int(dtpEnd.Date) + Frac(dtpEndTime.Time);
	goods := TPricedGoodRepository.GetPeriodHistory(
		BaseName,
		dtStart,
		dtEnd,
		checked
	);
	for i := 0 to high(goods) do
	begin
		with sgHistory do
		begin
			RowCount := RowCount + 1;
			Cells[0, i + 1] := IntToStr(goods[i].Id);
			Cells[1, i + 1] := goods[i].Good.Caption;
			Cells[2, i + 1] := PriceToStr(goods[i].Price);
			Cells[3, i + 1] := PriceToStr(goods[i].Amount);
			Cells[4, i + 1] := PriceToStr(goods[i].ActionAmount);
			Cells[5, i + 1] := PriceToStr(goods[i].DiscountAmount);
		end;
		cnts[0] := cnts[0] + goods[i].Amount - goods[i].DiscountAmount;
		cnts[1] := cnts[1] + goods[i].ActionAmount;
		cnts[2] := cnts[2] + goods[i].DiscountAmount;
		sums[0] := sums[0] + (goods[i].Amount - goods[i].DiscountAmount) * goods[i].Price;
		sums[1] := 0;
		sums[2] := sums[2] + goods[i].DiscountAmount * 0.9 * goods[i].Price;
	end;
	cnts[3] := cnts[0] + cnts[1] + cnts[2];
	sums[3] := sums[0] + sums[1] + sums[2];
	for i := 1 to 4 do
	begin
		sgResults.Cells[1, i] := PriceToStr(cnts[i - 1]);
		sgResults.Cells[2, i] := PriceToStr(sums[i - 1]);
    end;
end;

end.
