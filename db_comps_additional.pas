unit db_comps_additional;

interface
uses DB, IBX.IBQuery, IBX.IBDatabase, System.SysUtils, Vcl.Dialogs;
type
   TDBCompsAddit = class
   public
      query: TIBQuery;
      trans: TIBTransaction;
      dbconnect: TIBDatabase;
      constructor Create(fileName: string);
      destructor Destroy;
      function Init: Boolean;
   end;

implementation

{ TDBCompsAddit }

constructor TDBCompsAddit.Create(fileName: string);
begin
   inherited Create;
   dbconnect := TIBDatabase.Create(nil);
   with dbconnect do
   begin
      Params.Add('user_name=sysdba');
      Params.Add('password=masterkey');
      Params.Add('lc_ctype=UTF8');
      DatabaseName := fileName;
      LoginPrompt := false;
   end;
   trans := TIBTransaction.Create(nil);
   trans.DefaultDatabase := dbconnect;
   query := TIBQuery.Create(nil);
   with query do
   begin
      Database := dbconnect;
      Transaction := trans;
   end;
end;

destructor TDBCompsAddit.Destroy;
begin
   if (query <> nil) then
      FreeAndNil(query);
   if (trans <> nil) then
      FreeAndNil(trans);
   if (dbconnect <> nil) then
      FreeAndNil(dbconnect);
   inherited Destroy;
end;

function TDBCompsAddit.Init: Boolean;
begin
   if (dbconnect = nil) or (trans = nil) or (query = nil) then
   begin
      result := false;
      ShowMessage('Additional db object was corrupted.');
      Exit;
   end;
   try
      dbconnect.Open;
   except
      on E:Exception do
      begin
        result := False;
        ShowMessage('Cant create additional db object. Error: ' + E.Message);
        exit;
      end;
   end;
   result := true;
end;

end.
