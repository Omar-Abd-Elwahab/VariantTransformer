# Summary: 
Variant calling refinement is crucial for distinguishing true genetic variants from technical artifacts in high-throughput sequencing data. VariantTransformer, a Transformer-based deep learning model, was developed to automate variant calling refinement from low-coverage data using VCF files directly. Trained on two million variants from low-coverage sequencing data, VariantTransformer achieved an accuracy of 89.26% and a ROC AUC score of 0.88, outperforming default filtering methods and approaching the accuracy of AI-based variant callers. Comparative analysis showed VariantTransformer's superiority in functionality, variant type coverage, training size, and input data type.

# VariantTransformer
This repository serves as a comprehensive resource for the development and analysis of a deep-learning model for filtering genomic variants from VCFs. The trained model can be accessed at https://drive.google.com/drive/folders/1L_g9KWxBbYi7WfUr4-jgabfVmvu3Vjf2?usp=sharing. 

# Pre-print citation
Abdelwahab O and Torkamaneh D (2026) A Transformers-based framework for refinement of genetic variants. Front. Bioinform. 5:1694924. doi: 10.3389/fbinf.2025.1694924

# Information
Sequencing Data Acquisition:

    FASTQ files containing sequencing data for samples HG003, HG006, and HG007 were obtained from the Genome in a Bottle (GIAB) Consortium.
    Sequence coverages were 10.5X, 13.6X, and 12.6X respectively.

    Alignment:

    The raw FASTQ files were aligned using Sentieon BWA-MEM with the GRCh38 reference genome. 
    The code used for alignment can be found at https://github.com/Omar-Abd-Elwahab/Variant_Callers

    Variant Calling:

    Variant calling was performed using GATK4 HaplotypeCaller and BCFTools. 
    The exact commands for variant calling can be found at https://github.com/Omar-Abd-Elwahab/Variant_Callers

    Truth Set Comparison:

    The latest GIAB truth sets v4.2.1 were used to update the "FILTER" column in the resulting VCFs. 
    Variants common with the truth sets were marked as "PASS"; otherwise, they were marked as "FAIL".

    Data Transformation:

    For model training, columns "Chrom," "POS," "REF," and "ALT" were removed, and the remaining columns (except "FILTER") were merged into one. 
    This transformed the problem into a sentence classification problem where the merged column represented sentences and the "FILTER" column represented target labels.

    Dataset Creation:

    The updated VCFs from sample HG003 were merged. To reduce computational costs, 2 million variants were randomly selected from the merged VCF for initial model training and validation.

Training Process:

    Model Selection:

    The "BertForSequenceClassification" model from Hugging Face was used.

    Parameter Tuning:

    Several parameters were tuned, including adding unique VCF words to the BertTokenizer vocabulary and adjusting hyperparameters such as hidden size, number of attention heads, and intermediate size to optimize performance and computational efficiency.

    Training Configuration:

    The AdamW optimizer was employed across 21 epochs with a batch size of 1,300.

    Training Data Split:

    The data was randomly split into 60% for training and 40% for validation to avoid overfitting.

Testing Process:

    Integration into Pipelines:

    VariantTransformer was integrated into two conventional variant calling pipelines (BCFTools and GATK4).

    Performance Evaluation:

    The model's performance was evaluated using various accuracy metrics such as MCC, ROC AUC scores, accuracy, precision, recall, and F1 score.
    Comparative analysis was conducted against default filtering methods and AI-based variant callers like DeepVariant.

    Sample Testing:

    Testing was performed on two GIAB samples (HG006 and HG007) with coverages of 13.6X and 12.6X respectively.

    Results Analysis:

    The performance metrics were calculated using scikit-learn, and the results were compared with default filters and other AI-based tools.

By following these steps, the study aimed to demonstrate the effectiveness of VariantTransformer in automating the variant calling refinement process, particularly for low-coverage genomic data.
