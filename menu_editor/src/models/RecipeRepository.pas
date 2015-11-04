unit RecipeRepository;

interface

uses
	Recipe;

type
	TRecipeRepository = class
		class function GetAllForGood(ABaseName: string; AGoodId: integer): TRecipeArray;
		class function GetAll(ABaseName: string): TRecipeArray;
    end;

implementation

uses
	db_comps_additional, SysUtils, Good, Ingredient, Measure;
{ TRecipeRepository }

class function TRecipeRepository.GetAll(ABaseName: string): TRecipeArray;
var
	adc: TDBCompsAddit;
begin
	adc := TDBCompsAddit.Create(ABaseName);
	if not adc.Init then
	begin
		result := nil;
		raise Exception.Create('TRecipeRepository.GetAll(); Can not init adc');
		adc.Destroy;
		Exit;
	end;
	with adc.query do
	begin
		SQL.Text :=
			'SELECT ' +
				'r.id as r_id, r.amount as r_amount, r.good_id as r_good, ' +
				'i.id as i_id, i.caption as i_caption, i.createdAt as i_createdAt, ' +
				'i.expiredAt as i_expiredAt, ' +
				'm.id as m_id, m.caption as m_caption ' +
			'FROM ' +
				'recipes r INNER JOIN ingredients i ON r.ingr_id = i.id ' +
				'INNER JOIN goods g ON r.good_id = g.id ' +
				'INNER JOIN measures m ON i.measure_id = m.id ' +
			'WHERE ' +
				'r.expiredAt is NULL ' +
			'ORDER BY r.id';
		try
			Open;
		except
			on E:Exception do
			begin
				result := nil;
				raise Exception.Create(
					'TRecipeRepository.GetAll(); Can not execute query! Error: ' + E.Message
				);
				adc.Destroy;
				Exit;
			end;
		end;
		while not EOF do
		begin
			setlength(result, length(result) + 1);
			result[high(result)] := TRecipe.Create(
				FieldByName('r_id').AsInteger,
				TGood.Create(FieldByName('r_good').AsInteger),
				TIngredient.Create(
					FieldByName('i_id').AsInteger,
					FieldByName('i_caption').AsString,
					FieldByName('i_createdAt').AsDateTime,
					FieldByName('i_expiredAt').AsDateTime,
					TMeasure.Create(
						FieldByName('m_id').AsInteger,
						FieldByName('m_caption').AsString
					)
				),
				FieldByName('r_amount').AsFloat
			);
			Next;
		end;
	end;
	adc.Destroy;
end;

class function TRecipeRepository.GetAllForGood(ABaseName: string; AGoodId: integer): TRecipeArray;
var
	adc: TDBCompsAddit;
begin
	adc := TDBCompsAddit.Create(ABaseName);
	if not adc.Init then
	begin
		result := nil;
		raise Exception.Create('TRecipeRepository.GetAllForGood(); Can not init adc');
		adc.Destroy;
		Exit;
	end;
	with adc.query do
	begin
		SQL.Text :=
			'SELECT ' +
				'r.id as r_id, r.amount as r_amount, ' +
				'i.id as i_id, i.caption as i_caption, i.createdAt as i_createdAt, ' +
				'i.expiredAt as i_expiredAt, ' +
				'm.id as m_id, m.caption as m_caption ' +
			'FROM ' +
				'recipes r INNER JOIN ingredients i ON r.ingr_id = i.id ' +
				'INNER JOIN measures m ON i.measure_id = m.id ' +
			'WHERE ' +
				'r.good_id = :good_id AND r.expiredAt is NULL ' +
			'ORDER BY r.id';
		ParamByName('good_id').AsInteger := AGoodId;
		try
			Open;
		except
			on E:Exception do
			begin
				result := nil;
				raise Exception.Create(
					'TRecipeRepository.GetAllForGood(); Can not execute query! Error: ' + E.Message
				);
				adc.Destroy;
				Exit;
			end;
		end;
		while not EOF do
		begin
			setlength(result, length(result) + 1);
			result[high(result)] := TRecipe.Create(
				FieldByName('r_id').AsInteger,
				TGood.Create(AGoodId),
				TIngredient.Create(
					FieldByName('i_id').AsInteger,
					FieldByName('i_caption').AsString,
					FieldByName('i_createdAt').AsDateTime,
					FieldByName('i_expiredAt').AsDateTime,
					TMeasure.Create(
						FieldByName('m_id').AsInteger,
						FieldByName('m_caption').AsString
					)
				),
				FieldByName('r_amount').AsFloat
			);
			Next;
		end;
	end;
	adc.Destroy;
end;

end.
