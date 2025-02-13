CREATE TABLE parents AS
  SELECT "ace" AS parent, "bella" AS child UNION
  SELECT "ace"          , "charlie"        UNION
  SELECT "daisy"        , "hank"           UNION
  SELECT "finn"         , "ace"            UNION
  SELECT "finn"         , "daisy"          UNION
  SELECT "finn"         , "ginger"         UNION
  SELECT "ellie"        , "finn";

CREATE TABLE dogs AS
  SELECT "ace" AS name, "long" AS fur, 26 AS height UNION
  SELECT "bella"      , "short"      , 52           UNION
  SELECT "charlie"    , "long"       , 47           UNION
  SELECT "daisy"      , "long"       , 46           UNION
  SELECT "ellie"      , "short"      , 35           UNION
  SELECT "finn"       , "curly"      , 32           UNION
  SELECT "ginger"     , "short"      , 28           UNION
  SELECT "hank"       , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child FROM dogs, parents WHERE name = parent
    ORDER BY  height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size FROM dogs, sizes
  WHERE height > min AND height <= max;


-- [Optional] Filling out this helper table is recommended
CREATE TABLE siblings AS
  SELECT a.child AS sibling1, b.child AS sibling2, sizes_a.size AS size1, sizes_b.size AS size2
  FROM parents AS a, parents AS b, sizes AS sizes_a , sizes AS sizes_b, dogs AS dogs_a, dogs AS dogs_b
  WHERE a.parent = b.parent AND a.child < b.child AND a.child = dogs_a.name AND b.child = dogs_b.name AND (dogs_a.height > sizes_a.min AND dogs_a.height <= sizes_a.max) AND (dogs_b.height > sizes_b.min AND dogs_b.height <= sizes_b.max);

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, " || sibling1 || " and " || sibling2 || ", have the same size: " || size1 FROM siblings
  WHERE size1 = size2;

-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur,
        MAX(height) - MIN(height) AS height_range
  FROM dogs
  GROUP BY fur
  HAVING   MIN(height) > AVG(height) * 0.7
    AND    MAX(height) < AVG(height) * 1.3 ;
