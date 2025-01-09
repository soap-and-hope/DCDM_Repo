
# Database Tables and SQL Scripts with Annotations

## 1. Mouse Table
```sql
-- Create the Mouse table
CREATE TABLE `Mouse` (
    `parameter_id` VARCHAR(255) NOT NULL,  -- Unique identifier for each parameter
    `gene_accession_id` VARCHAR(255) NOT NULL,  -- Accession ID of the associated gene
    `analysis_id` VARCHAR(255) NOT NULL,
    `parameter_name` VARCHAR(255) DEFAULT NULL,
    `pvalue` DOUBLE NULL,  -- P-value from the analysis (statistical significance)
    `gene_symbol` VARCHAR(50) NOT NULL,
    `mouse_strain` VARCHAR(50) NOT NULL,
    `mouse_life_stage` VARCHAR(50) NOT NULL,  -- Life stage of the mouse (E.g. Adult) 
    
    -- Defining a composite primary key on parameter_id and analysis_id. A composite primary key ensures that each combination of parameter and analysis is unique.
    PRIMARY KEY (`parameter_id`, `analysis_id`)
);
```
The composite primary key (parameter_id, analysis_id) ensures that each combination of parameter and analysis is unique.

## 2. Phenotype Table
```sql
-- Create the Phenotype table
CREATE TABLE `Phenotype` (
    `parameter_id` VARCHAR(255) NOT NULL,
    `parameter_name` VARCHAR(255) NOT NULL,
    `parameter_description` TEXT,
    `impc_parameter_orig_id` VARCHAR(255) NOT NULL,  -- Original IMPc parameter ID
    `parameter_group_id` INT(11) DEFAULT NULL,  -- Foreign key linking to the Parameter_Group table
    
    -- Defining a composite primary key on parameter_id and impc_parameter_orig_id
    PRIMARY KEY (`parameter_id`, `impc_parameter_orig_id`),
    
    -- Indexes for foreign keys to improve query performance
    KEY `fk_impc_parameter_orig_id` (`impc_parameter_orig_id`),
    KEY `parameter_group_id` (`parameter_group_id`),
    
    -- Foreign key constraint linking parameter_group_id to the Parameter_Group table
    CONSTRAINT `phenotype_ibfk_1` FOREIGN KEY (`parameter_group_id`) REFERENCES `Parameter_Group` (`parameter_group_id`)
);
```
Composite Primary Key: The combination of parameter_id and impc_parameter_orig_id allows parameters to be identified uniquely across different datasets.
Foreign Key Constraint: The parameter_group_id column references the parameter_group table. This creates a relational link, enabling queries to retrieve parameters by group.

## 3. Procedures Table
```sql
-- Create the Procedures table
CREATE TABLE `Procedures` (
    `procedure_name` VARCHAR(255) DEFAULT NULL,
    `procedure_description` TEXT, 
    `is_mandatory` TINYINT(1) NOT NULL,  -- Indicating whether the procedure is mandatory (1 = Yes, 0 = No)
    `impc_parameter_orig_id` VARCHAR(255) NOT NULL,  -- Original IMPc parameter ID linked to this procedure
    
    -- Defining the primary key on impc_parameter_orig_id
    PRIMARY KEY (`impc_parameter_orig_id`),
    
    -- Ensuring uniqueness on impc_parameter_orig_id
    UNIQUE KEY `impc_parameter_orig_id` (`impc_parameter_orig_id`)
);
```
The is_mandatory column uses a TINYINT(1) data type to store binary values (1 for mandatory, 0 for optional procedures).

## 4. Human_Disease Table
```sql
-- Create the Human_Disease table
CREATE TABLE `Human_Disease` (
    `disease_id` VARCHAR(255) NOT NULL,
    `gene_accession_id` VARCHAR(255) NOT NULL,
    `disease_term` TEXT NOT NULL,
    `phenodigm_score` DOUBLE DEFAULT NULL,  -- Phenodigm score indicating phenotype similarity between human and mouse
    
    -- Defining the primary key on disease_id
    PRIMARY KEY (`disease_id`)
);
```

## 5. Parameter_Group Table
```sql
-- Create the Parameter_Group table
CREATE TABLE `Parameter_Group` (
    `parameter_group_id` INT(11) NOT NULL AUTO_INCREMENT,  -- Auto-incremented unique ID for each parameter group
    `group_name` VARCHAR(255) NOT NULL,
    
    -- Defining the primary key on parameter_group_id
    PRIMARY KEY (`parameter_group_id`)
);
```
group_name provides a label for each parameter group, e.g., “Weight Parameters” or “Brain Parameters”.

## 6. Parameter Group Insertion and Table Updates
```sql
-- Insert Parameter Groups into Parameter_Group
INSERT INTO Parameter_Group (group_name)
VALUES 
    ('Weight Parameters'),
    ('Image Parameters'),
    ('Brain Parameters'),
    ('Cardiovascular Parameters'),
    ('Heart Parameters'),
    ('Electrolytes Parameters');

-- Alter Phenotype Table to Add parameter_group_id
ALTER TABLE Phenotype
ADD COLUMN parameter_group_id INT,  -- Add a column to store the parameter group ID
ADD FOREIGN KEY (parameter_group_id) REFERENCES Parameter_Group(parameter_group_id);  -- Add a foreign key constraint linking to the Parameter_Group table

-- Update Phenotype Table with parameter_group_id Values

-- Weight Parameters
UPDATE Phenotype
SET parameter_group_id = (SELECT parameter_group_id FROM Parameter_Group WHERE group_name = 'Weight Parameters')
WHERE parameter_name IN ('Body weight', 'Fat mass', 'Lean mass', 'Heart weight', 'Liver weight', 'Lung weight', 'Spleen weight', 'Adrenal gland weight');

-- Image Parameters
UPDATE Phenotype
SET parameter_group_id = (SELECT parameter_group_id FROM Parameter_Group WHERE group_name = 'Image Parameters')
WHERE parameter_name IN ('XRay Images Whole Body Dorso Ventral', 'XRay Images Whole Body Lateral Orientation', 'XRay Images Skull Lateral Orientation', 'XRay Images Skull Dorso Ventral Orientation');

-- Brain Parameters
UPDATE Phenotype
SET parameter_group_id = (SELECT parameter_group_id FROM Parameter_Group WHERE group_name = 'Brain Parameters')
WHERE parameter_name IN ('Brainstem', 'Forebrain', 'Midbrain', 'Hindbrain', 'Cerebral Cortex', 'Hippocampus', 'Cerebellum');

-- Cardiovascular Parameters
UPDATE Phenotype
SET parameter_group_id = (SELECT parameter_group_id FROM Parameter_Group WHERE group_name = 'Cardiovascular Parameters')
WHERE parameter_name IN ('HR', 'Stroke volume', 'Ejection fraction', 'Cardiac output', 'End-Systolic Diameter', 'End-Diastolic Diameter');

-- Heart Parameters
UPDATE Phenotype
SET parameter_group_id = (SELECT parameter_group_id FROM Parameter_Group WHERE group_name = 'Heart Parameters')
WHERE parameter_name IN ('Vena cava', 'Ventricle', 'Atrium', 'Pericardium', 'Tricuspid', 'Atria', 'Aorta', 'Pulmonary');

-- Electrolytes Parameters
UPDATE Phenotype
SET parameter_group_id = (SELECT parameter_group_id FROM Parameter_Group WHERE group_name = 'Electrolytes Parameters')
WHERE parameter_name IN ('Sodium', 'Potassium', 'Chloride', 'Calcium', 'Phosphate');
```
These UPDATE statements link parameter groups for brain, cardiovascular, heart, and electrolytes-related parameters by updating the parameter_group_id in the Phenotype table. Each query ensures that parameters are correctly assigned to their respective groups, enabling structured analysis and retrieval.
