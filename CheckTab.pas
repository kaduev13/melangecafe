unit CheckTab;

interface
uses Vcl.ComCtrls, Vcl.Grids, Vcl.Controls, Dialogs, System.SysUtils, Vcl.ExtCtrls,
   Vcl.StdCtrls, System.Types, Vcl.Graphics, System.Classes;
type
   TRGood = record
      id: Integer;
      amount, actionAmount: Double;
      actionAble: boolean;
   end;

   TCheckTab = class
   public
      grid: TStringGrid;
      tab: TTabSheet;
      name: string;
      pc: TPageControl;
      tag: integer;
      isReturn: boolean;
      pnlSumm: TPanel;
      lblSumm: TLabel;
      edtSumm: TEdit;
      goods: array of TRGood;
      isFakePrinted: boolean;
   public
      constructor Create(APc: TPageControl; ATag: integer);
      procedure SetReturned;
      procedure AddGoodInfo(AId: integer; AAmount, AActionAmount: double; AActionAble: boolean);
      destructor Destroy;
      procedure DoDeleteGood(AId: integer);
   private
      procedure ReturnedGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
      procedure gridMouseUp(Sender: TObject; Button: TMouseButton;
         Shift: TShiftState; X, Y: Integer);
   end;
implementation

uses
  vars, PlatformSizes, ValInput;


{ TCheckTab }

procedure TCheckTab.AddGoodInfo(AId: integer; AAmount, AActionAmount: double;
   AActionAble: boolean);
begin
   setlength(goods, length(goods) + 1);
   with goods[high(goods)] do
   begin
      id := AId;
      amount := AAmount;
      actionAmount := AActionAmount;
      actionAble := AActionAble;
   end;
end;

constructor TCheckTab.Create(APc: TPageControl; ATag: integer);
begin
   tag := ATag;
   tab := TTabSheet.Create(APc);
   with tab do
   begin
      Parent := TWinControl(APc);
      PageControl := APc;
      Align := alClient;
      Caption := GetText(false, '�������� �����', '������� ��������');
      Tag := ATag;
   end;
   pnlSumm := TPanel.Create(tab);
   with pnlSumm do
   begin
      Parent := TWinControl(tab);
      align := alBottom;
      height := Sizes.checkPnlSummHeight;
   end;
   lblSumm := TLabel.Create(pnlSumm);
   with lblSumm do
   begin
      Parent := TWinControl(pnlSumm);
      Caption := '����� �����:';
      Left := Sizes.checkLblSummLeft;
      Top := Sizes.checkLblSummTop;
      Width := Sizes.checkLblSummWidth;
	  Height := Sizes.checkLblSummHeight;
	  Font.Size := Sizes.checkGridFontSize;
   end;
   edtSumm := TEdit.Create(pnlSumm);
   with edtSumm do
   begin
      Parent := TWinControl(pnlSumm);
      Text := '0';
      Width := Sizes.checkEdtSummWidth;
      Left := lblSumm.Left + Sizes.checkEdtMargin;
      Top := lblSumm.Top;
      Height := lblSumm.Height;
	  ReadOnly := true;
	  Font.Size := Sizes.checkGridFontSize;
   end;
   grid := TStringGrid.Create(tab);
   with grid do
   begin
      Font.Size := Sizes.checkGridFontSize;
      Parent := TWinControl(tab);
      ColCount := 5;
      RowCount := 1;
      Align := alClient;
      Cells[0, 0] := '��������';
      ColWidths[0] := Sizes.checkGridCol0Width;
      Cells[1, 0] := '����';
      ColWidths[1] := Sizes.checkGridCol1Width;
      Cells[2, 0] := '�/�';
      ColWidths[2] := Sizes.checkGridCol2Width;
      Cells[3, 0] := '�/a';
      ColWidths[3] := Sizes.checkGridCol3Width;
      Cells[4, 0] := '���������';
      ColWidths[4] := Sizes.checkGridCol4Width;
      Options := Options - [goEditing];
//      OnDblClick := gridDblClick;
      OnMouseUp := gridMouseUp;
   end;
end;

destructor TCheckTab.Destroy;
begin
   FreeAndNil(lblSumm);
   FreeAndNil(edtSumm);
   FreeAndNil(pnlSumm);
   FreeAndNil(grid);
   FreeAndNil(tab);
end;

procedure TCheckTab.DoDeleteGood(AId: integer);
var
   i: integer;
   summ: double;
begin
   summ := goods[AId].amount * StrToPrice(grid.Cells[1, AId + 1]);
   summ := StrToPrice(edtSumm.Text) - summ;
   edtSumm.Text := PriceToStr(summ);
   for i := AId to High(goods) - 1 do
      goods[i] := goods[i + 1];
   SetLength(goods, length(goods) - 1);
   for i := AId + 1 to grid.RowCount - 2 do
   begin
      grid.Rows[i].Assign(grid.Rows[i + 1]);
   end;
   if grid.RowCount > 1 then
      grid.RowCount := grid.RowCount - 1;
end;

procedure TCheckTab.ReturnedGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
   if ARow = 0 then
   begin
      grid.Canvas.Brush.Color := clRed;
      grid.Canvas.Font.Color := clWhite;
      grid.Canvas.FillRect(Rect);
      grid.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, grid.Cells[ACol, ARow]);
   end;
end;

procedure TCheckTab.SetReturned;
begin
   isReturn := true;
   grid.OnDrawCell := ReturnedGridDrawCell;
   grid.Invalidate;
end;

procedure TCheckTab.gridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   ns: string;
   n, na: Double;
   arow, acol: integer;
   summ, price: double;
begin
   (Sender as TStringGrid).MouseToCell(x, y, acol, arow);
   if arow <= 0 then
      exit;
   if (ssCtrl in Shift) then
   begin
      if (MessageDlg('����������� �������� ������!',mtWarning, [mbYes, mbNo], 0) = mrYes) then
         DoDeleteGood(arow - 1);
      Exit;
   end;
   n := goods[arow - 1].amount;

   ns := GetText(true, '������� ����������!', '���������� ��� �����:');
   try
      n := StrToPrice(ns);
   except
      on E:Exception do
      begin
         ShowMessage('������� �� ���������� ���������� ������.');
         exit;
      end;
   end;
   if n < 0 then
   begin
      ShowMessage('���������� �� ����� ���� �������������!');
      exit;
   end;
   na := goods[arow - 1].actionAmount;
   if goods[arow - 1].actionAble then
   begin
      ns := GetText(true, '������� ����������!', '���������� � ������:');
      try
         na := StrToPrice(ns);
      except
         on E:Exception do
         begin
            ShowMessage('������� �� ���������� ���������� ������.');
            exit;
         end;
      end;
      if na < 0 then
      begin
         ShowMessage('���������� �� ����� ���� �������������!');
         exit;
      end;
   end;
   if n + na = 0 then
   begin
      if (MessageDlg('����������� �������� ������!',mtWarning, [mbYes, mbNo], 0) = mrYes) then
         DoDeleteGood(arow - 1);
      Exit;
   end;
   grid.Cells[2, arow] := PriceToStr(n);
   grid.Cells[3, arow] := PriceToStr(na);
   price := StrToPrice(grid.Cells[1, arow]);
   summ := StrToPrice(edtSumm.Text);
   summ := summ - price * goods[arow - 1].amount; //old amount!!!
   summ := summ + n * price;
   goods[arow - 1].amount := n;
   goods[arow - 1].actionAmount := na;
   grid.Cells[4, arow] := PriceToStr(price * goods[arow - 1].amount);
   edtSumm.Text := PriceToStr(summ);
end;

end.
