
# MySQL Query Documentation for Genotype Analysis

This document provides a set of MySQL queries to retrieve detailed information about specific genotypes from the database. Each query includes an explanation of its purpose and the expected output.

## 1. Querying All Information for a Specific Genotype

**Purpose**: Retrieve all records related to a specific genotype from the `Mouse` table, including associated parameters and p-values.

**Query**:
```sql
SELECT *
FROM Mouse
WHERE gene_symbol = 'Phyhd1';
```
This query returns all entries where the `gene_symbol` is `Phyhd1`, including the `parameter_id`, `analysis_id`, `pvalue`, and mouse strain details.

```sql
SELECT *
FROM Mouse
WHERE gene_symbol = 'Cwc22';
```

```sql
SELECT *
FROM Mouse
WHERE gene_symbol = 'Slc7a13';
```

```sql
SELECT *
FROM Mouse
WHERE gene_symbol = 'Emcn';
```

```sql
SELECT m.gene_symbol,m.parameter_name,m.pvalue,pg.group_name AS parameter_group,pr.procedure_name,pr.procedure_description
FROM Mouse m
LEFT JOIN Phenotype p ON m.parameter_id = p.parameter_id
LEFT JOIN Parameter_Group pg ON p.parameter_group_id = pg.parameter_group_id
LEFT JOIN Procedures pr ON p.impc_parameter_orig_id = pr.impc_parameter_orig_id
WHERE m.gene_symbol IN ('Phyhd1', 'Cwc22', 'Slc7a13', 'Emcn');
```

---

## 2. Querying Parameter Groups Associated with a Specific Genotype

**Purpose**: Find which parameter groups the parameters associated with a specific genotype belong to.

**Query**:
```sql
SELECT m.gene_symbol, p.parameter_name, pg.group_name
FROM Mouse m
JOIN Phenotype p ON m.parameter_id = p.parameter_id
JOIN Parameter_Group pg ON p.parameter_group_id = pg.parameter_group_id
WHERE m.gene_symbol = 'Phyhd1';
```

This query joins the `Mouse`, `Phenotype`, and `Parameter_Group` tables to display the gene symbol, parameter name, and the corresponding parameter group for `Phyhd1`. 

```sql
SELECT m.gene_symbol, p.parameter_name, pg.group_name
FROM Mouse m
JOIN Phenotype p ON m.parameter_id = p.parameter_id
JOIN Parameter_Group pg ON p.parameter_group_id = pg.parameter_group_id
WHERE m.gene_symbol = 'Cwc22';
```

```sql
SELECT m.gene_symbol, p.parameter_name, pg.group_name
FROM Mouse m
JOIN Phenotype p ON m.parameter_id = p.parameter_id
JOIN Parameter_Group pg ON p.parameter_group_id = pg.parameter_group_id
WHERE m.gene_symbol = 'Slc7a13';
```

```sql
SELECT m.gene_symbol, p.parameter_name, pg.group_name
FROM Mouse m
JOIN Phenotype p ON m.parameter_id = p.parameter_id
JOIN Parameter_Group pg ON p.parameter_group_id = pg.parameter_group_id
WHERE m.gene_symbol = 'Emcn';
```

```sql
SELECT DISTINCT m.gene_symbol, pg.group_name AS parameter_group
FROM Mouse m
LEFT JOIN Phenotype p ON m.parameter_id = p.parameter_id
LEFT JOIN Parameter_Group pg ON p.parameter_group_id = pg.parameter_group_id
WHERE m.gene_symbol IN ('Phyhd1', 'Cwc22', 'Slc7a13', 'Emcn');
```

---

## 3. Querying P-Values for Specific Genotypes

**Purpose**: Retrieve the p-values associated with the parameters for each genotype.

**Query**:
```sql
SELECT m.gene_symbol, p.parameter_name, m.pvalue
FROM Mouse m
JOIN Phenotype p ON m.parameter_id = p.parameter_id
WHERE m.gene_symbol = 'Phyhd1';
```

```sql
SELECT m.gene_symbol, p.parameter_name, m.pvalue
FROM Mouse m
JOIN Phenotype p ON m.parameter_id = p.parameter_id
WHERE m.gene_symbol = 'Cwc22';
```

```sql
SELECT m.gene_symbol, p.parameter_name, m.pvalue
FROM Mouse m
JOIN Phenotype p ON m.parameter_id = p.parameter_id
WHERE m.gene_symbol = 'Slc7a13';
```

```sql
SELECT m.gene_symbol, p.parameter_name, m.pvalue
FROM Mouse m
JOIN Phenotype p ON m.parameter_id = p.parameter_id
WHERE m.gene_symbol = 'Emcn';
```

---

## 4. Querying Procedures for Parameters Associated with Genotypes

**Purpose**: Identify the procedures associated with the parameters for each genotype.

**Query**:
```sql
SELECT m.gene_symbol, p.parameter_name, pr.procedure_name
FROM Mouse m
JOIN Phenotype p ON m.parameter_id = p.parameter_id
JOIN Procedures pr ON p.impc_parameter_orig_id = pr.impc_parameter_orig_id
WHERE m.gene_symbol = 'Phyhd1';
```

```sql
SELECT m.gene_symbol, p.parameter_name, pr.procedure_name
FROM Mouse m
JOIN Phenotype p ON m.parameter_id = p.parameter_id
JOIN Procedures pr ON p.impc_parameter_orig_id = pr.impc_parameter_orig_id
WHERE m.gene_symbol = 'Cwc22';
```

```sql
SELECT m.gene_symbol, p.parameter_name, pr.procedure_name
FROM Mouse m
JOIN Phenotype p ON m.parameter_id = p.parameter_id
JOIN Procedures pr ON p.impc_parameter_orig_id = pr.impc_parameter_orig_id
WHERE m.gene_symbol = 'Slc7a13';
```

```sql
SELECT m.gene_symbol, p.parameter_name, pr.procedure_name
FROM Mouse m
JOIN Phenotype p ON m.parameter_id = p.parameter_id
JOIN Procedures pr ON p.impc_parameter_orig_id = pr.impc_parameter_orig_id
WHERE m.gene_symbol = 'Emcn';
```

```sql
SELECT DISTINCT m.gene_symbol, pr.procedure_name, pr.procedure_description
FROM Mouse m
LEFT JOIN Phenotype p ON m.parameter_id = p.parameter_id
LEFT JOIN Procedures pr ON p.impc_parameter_orig_id = pr.impc_parameter_orig_id
WHERE m.gene_symbol IN ('Phyhd1', 'Cwc22', 'Slc7a13', 'Emcn');
```

---

## Conclusion

These queries provide method for extracting detailed information on the specified genotypes (Phyhd1, Cwc22, Slc7a13, Emcn). They encompass parameters, parameter groups, p-values, and related procedures, providing the collaborator with all necessary data for their analysis.