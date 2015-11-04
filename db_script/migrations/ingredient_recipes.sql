CREATE TABLE Ingredient_recipes(
	id INTEGER NOT NULL,
	src_id INTEGER NOT NULL,
	part_id INTEGER NOT NULL,
	createdAt TIMESTAMP NOT NULL,
	expiredAt TIMESTAMP,
	amount FLOAT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(src_id) REFERENCES Ingredients(id) ON DELETE CASCADE,
	FOREIGN KEY(part_id) REFERENCES Ingredients(id) ON DELETE CASCADE
);

CREATE GENERATOR GEN_INGREDIENT_RECIPES_ID;

SET term ^;
CREATE TRIGGER trig_INGREDIENT_RECIPES_IDS for Ingredient_recipes
ACTIVE BEFORE INSERT POSITION 0
AS
    BEGIN
    	new.createdAt = CURRENT_TIMESTAMP;
        new.id = GEN_ID(GEN_INGREDIENT_RECIPES_ID, 1);
    END^
SET term ;^
