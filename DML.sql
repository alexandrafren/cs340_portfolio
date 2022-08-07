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
SELECT Bundles.bundle_id AS ID,
        Bundles.name AS Name,
        Bundles.description AS Description
        FROM Bundles
        ORDER BY ID ASC;

-- -----------------------------------------------------
-- BundleItems Operations
-- -----------------------------------------------------

-- Add item to bundle
INSERT INTO BundleItems (bundle_id, item_id)
VALUES (:bundle_id, :item_id);

-- Get all bundle items with names
SELECT BundleItems.bundle_items_id AS ID,
        BundleItems.bundle_id AS BundleID,
        Bundles.name AS BundleName,
        BundleItems.item_id AS ItemID,
        Items.name AS itemName
        FROM BundleItems
        INNER JOIN Bundles ON BundleItems.bundle_id = Bundles.bundle_id
        INNER JOIN Items ON BundleItems.item_id = Items.item_id
        ORDER BY BundleName ASC;

-- Get bundles
SELECT DISTINCT bundle_id,
        name
        FROM Bundles;

-- Get items
SELECT DISTINCT item_id,
        name
        FROM Items;

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
SELECT Regions.region_id AS ID,
        Regions.name AS Name,
        Regions.description AS Description
        FROM Regions
        ORDER BY ID ASC;

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
SELECT Shops.shop_id AS ID,
        Shops.name AS Name,
        Shops.description AS Description,
        NonPlayableCharacters.name AS Shopkeeper,
        Regions.name AS Region,
        Shops.operating_hours AS OperatingHours
        FROM Shops
        INNER JOIN NonPlayableCharacters ON Shops.shop_character_id = NonPlayableCharacters.character_id
        INNER JOIN Regions ON Shops.region_id = Regions.region_id
        ORDER BY ID ASC;

-- Get shopkeepers
SELECT DISTINCT character_id,
        name
        FROM NonPlayableCharacters;

-- Get shop regions
SELECT DISTINCT region_id,
        name
        FROM Regions;

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
