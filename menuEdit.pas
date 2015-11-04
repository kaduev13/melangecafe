unit menuEdit;
//
interface
//
//uses
//  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
//  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls, vars,
//  Vcl.ExtCtrls, Math;
//
//type
//  TfmMenuEdit = class(TForm)
//    sgMenu: TStringGrid;
//    btnAdd: TButton;
//    btnDelete: TButton;
//    pnlAdditBtns: TPanel;
//    pnlGrid: TPanel;
//    pnlBtns: TPanel;
//    btnOpen: TButton;
//    btnSave: TButton;
//    btnSaveAs: TButton;
//    edtPath: TEdit;
//    flpndlg1: TFileOpenDialog;
//    flsvdlg1: TFileSaveDialog;
//    btnMakeCurrent: TButton;
//    procedure FormCreate(Sender: TObject);
//    procedure btnAddClick(Sender: TObject);
//    procedure btnDeleteClick(Sender: TObject);
//    procedure btnOpenClick(Sender: TObject);
//    procedure btnSaveClick(Sender: TObject);
//    procedure btnSaveAsClick(Sender: TObject);
//    procedure btnMakeCurrentClick(Sender: TObject);
//  private
//    mymenu: TMyMenu;
//    { Private declarations }
//  public
//    { Public declarations }
//  end;
//
////var
////  fmMenuEdit: TfmMenuEdit;
//
implementation
//
//{$R *.dfm}
//
//procedure TfmMenuEdit.btnAddClick(Sender: TObject);
//begin
//   sgMenu.RowCount := sgMenu.RowCount + 1;
//end;
//
//procedure TfmMenuEdit.btnDeleteClick(Sender: TObject);
//var
//   idx: integer;
//   i: integer;
//begin
//   idx := sgMenu.Selection.Top;
//   if (idx > 0) and (idx < sgMenu.RowCount) then
//   begin
//      for i := idx to sgMenu.RowCount - 2 do
//      begin
//         sgMenu.Cells[0, i] := sgMenu.Cells[0, i + 1];
//         sgMenu.Cells[1, i] := sgMenu.Cells[1, i + 1];
//      end;
//      sgMenu.RowCount :=  max(1, sgMenu.RowCount - 1);
//   end;
//end;
//
//procedure TfmMenuEdit.btnMakeCurrentClick(Sender: TObject);
//begin
//   if edtPath.Text <> '' then
//      CURRENT_MENU_PATH := edtPath.Text;
//end;
//
//procedure TfmMenuEdit.btnOpenClick(Sender: TObject);
//begin
//   if flpndlg1.Execute then
//   begin
//      mymenu := TMyMenu.Create(flpndlg1.FileName);
//      edtPath.Text := mymenu.path;
//      mymenu.DrawOnGrid(sgMenu);
//   end;
//end;
//
//procedure TfmMenuEdit.btnSaveAsClick(Sender: TObject);
//begin
//if flsvdlg1.Execute then
//   begin
//      mymenu.SynchWithGrid(sgMenu);
//      mymenu.saveto(flsvdlg1.FileName);
//      edtPath.Text := mymenu.path;
//   end;
//end;
//
//procedure TfmMenuEdit.btnSaveClick(Sender: TObject);
//begin
//   if mymenu.path <> '' then
//   begin
//      mymenu.SynchWithGrid(sgMenu);
//      mymenu.saveto(mymenu.path)
//   end
//   else if flsvdlg1.Execute then
//   begin
//      mymenu.SynchWithGrid(sgMenu);
//      mymenu.saveto(flsvdlg1.FileName);
//      edtPath.Text := mymenu.path;
//   end;
//end;
//
//procedure TfmMenuEdit.FormCreate(Sender: TObject);
//begin
//   mymenu := TMyMenu.Create(CURRENT_MENU_PATH);
//   mymenu.DrawOnGrid(sgMenu);
//   edtPath.Text := mymenu.path;
//end;
//
end.
