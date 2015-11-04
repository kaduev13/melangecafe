unit MeasureRepository;

interface
uses
	Measure;

type
	TMeasureRepository = class
	public
		class function GetAll(ABaseName: string): TMeasureArray;
	end;

implementation

uses
	db_comps_additional, SysUtils;
{ TMeasureRepository }

class function TMeasureRepository.GetAll(ABaseName: string): TMeasureArray;
var
	adc: TDBCompsAddit;
begin
	adc := TDBCompsAddit.Create(ABaseName);
	if not adc.Init then
	begin
		result := nil;
		raise Exception.Create('TMeasureRepository.GetAll(); Can not init adc');
		adc.Destroy;
		Exit;
	end;
	with adc.query do
	begin
		SQL.Text := 'SELECT id, caption FROM measures ORDER BY id';
		try
			Open;
		except
			on E:Exception do
			begin
				result := nil;
				raise Exception.Create(
					'TMeasureRepository.GetAll(); Can not execute query! Error: ' + E.Message
				);
				adc.Destroy;
				Exit;
			end;
		end;
		while not eof do
		begin
			setlength(result, length(result) + 1);
			result[high(result)] := TMeasure.Create(
				FieldByName('id').AsInteger,
				FieldByName('caption').AsString
			);
			Next;
		end;
	end;
	adc.Destroy;
end;

end.
