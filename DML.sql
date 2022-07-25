-- CS 340 Intro to Databases
-- Project Step 3 Draft: DML
-- Team 35
-- Members: Alexandra Fren, Raymond Zhang

-- -----------------------------------------------------
-- Bundles Operations
-- -----------------------------------------------------

-- Add new bundle entry
INSERT INTO Bundles (name, description)
VALUES (:name, :description);

-- Get all bundles
SELECT bundle_id,
    name,
    description
FROM Bundles;

-- -----------------------------------------------------
-- BundleItems Operations
-- -----------------------------------------------------

-- Add item to bundle
INSERT INTO BundleItems (bundle_id, item_id)
VALUES (:bundle_id, :item_id);

-- Get all bundle items with names
SELECT bundle_items_id,
    Bundles.name AS bundleName,
    Items.name AS itemName
FROM BundleItems
    INNER JOIN Bundles ON BundleItems.bundle_id = Bundles.bundle_id
    INNER JOIN Items ON BundleItems.item_id = Items.item_id
ORDER BY bundleName ASC;

-- -----------------------------------------------------
-- CharacterItems Operations
-- -----------------------------------------------------

-- Add item to NPC's inventory
INSERT INTO CharacterItems (character_id, item_id)
VALUES (:character_id, :item_id);

-- Get all Character's items with names
SELECT character_items_id,
    NonPlayableCharacters.name AS characterName,
    Items.name AS itemName
FROM CharacterItems
    INNER JOIN NonPlayableCharacters ON CharacterItems.character_id = NonPlayableCharacters.character_id
    INNER JOIN Items ON CharacterItems.item_id = Items.item_id
ORDER BY characterName ASC;

-- Delete an item from NPC's inventory
DELETE FROM CharacterItems
WHERE character_items_id =: character_items_id 

-- Update an item in NPC's inventory
UPDATE CharacterItems
SET item_id = :item_id
WHERE character_items_id = : character_items_id 

-- -----------------------------------------------------
-- NPC Operations
-- -----------------------------------------------------

-- Add new character
INSERT INTO NonPlayableCharacters (
        name,
        occupation,
        birthday,
        is_romanceable,
        region_id,
        description
    )
VALUES (
        :name,
        :occupation,
        :birthday,
        :is_romanceable,
        :region_id,
        :description
    );

-- Get all Characters
-- The region_id FK is NULLable since some characters may not belong to a region
SELECT character_id,
    name,
    occupation,
    birthday,
    is_romanceable,
    region_id,
    description
FROM NonPlayableCharacters;

-- -----------------------------------------------------
-- Items Operations
-- -----------------------------------------------------

-- Add new Item
INSERT INTO Items (
        name,
        seasons,
        description
    )
VALUES (
        :name,
        :seasons,
        :description
    );

-- Get all Items
SELECT item_id,
        name,
        seasons,
        description
FROM Items
ORDER BY name ASC;

-- Search Item
SELECT item_id,
        name,
        seasons,
        description
FROM Items
WHERE name LIKE %:search%;

-- Delete an item
DELETE FROM Items
WHERE item_id =: item_id 

-- Update an item
UPDATE Items
SET name = :name,
    description = :description,
    seasons = :seasons
WHERE item_id = : item_id 

-- -----------------------------------------------------
-- Regions Operations
-- -----------------------------------------------------

-- Add new Region
INSERT INTO Regions (
        name,
        description
    )
VALUES (
        :name,
        :description
    );

-- Get all Regions
SELECT region_id,
        name,
        description
FROM Regions
ORDER BY name ASC;

-- -----------------------------------------------------
-- Shops Operations
-- -----------------------------------------------------

-- Add new Shop
INSERT INTO Shops (
        name,
        operating_hours,
        shop_character_id,
        region_id,
        description
    )
VALUES (
        :name,
        :operating_hours,
        :shop_character_id,
        :region_id,
        :description
    );

-- Get all Shops
SELECT shop_id,
        name,
        operating_hours,
        shop_character_id,
        region_id,
        description
FROM Shops
ORDER BY name ASC;

-- -----------------------------------------------------
-- ShopItems Operations
-- -----------------------------------------------------

-- Add item to shop
INSERT INTO ShopItems (shop_id, item_id)
VALUES (:shop_id, :item_id);

-- Get all items from shops by name
SELECT shop_items_id,
    Shops.name AS shopName,
    Items.name AS itemName
FROM ShopItems
    INNER JOIN Shops ON ShopItems.shop_id = Shops.shop_id
    INNER JOIN Items ON ShopItems.item_id = Items.item_id
ORDER BY shopName ASC;
