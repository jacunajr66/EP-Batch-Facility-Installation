# EP Batch Facility

This repository contains command-line utilities and configuration files used to manage and support the EP Batch Facility for BlueYonder-based enterprise implementations. The structure supports deployment across primary and secondary mid-tier servers, along with optional components tailored to specific environments and client needs.

---

## 🔧 Directory Structure

- `Primary/`  
  Install on the **primary mid-tier** server.

- `Secondary/`  
  Install on the **secondary mid-tier** server.  
  > **Note:** Only required if the secondary server runs batch jobs (beyond mid-tier restarts).

- `Add-Ons/`  
  Contains **optional features** referenced in EP Batch documentation.  
  Install only when needed for a specific implementation.

---

## ⚙️ Global Configuration (`GlobalVariables.bat`)

### 🔁 Primary vs. Secondary
Set the `PRISEC` variable in `GlobalVariables.bat` as follows:
- On **primary** mid-tier: `PRISEC=primary`
- On **secondary** mid-tier: `PRISEC=secondary`

All other variables should remain consistent across both tiers unless otherwise required.

---

## 🏗️ Implementation-Specific Variables

The following variables **must be set** according to the implementation:

- `DATASOURCE`
- `MULE`
- `MULEENV`
- `DSSERVER`  *(for JI on DataStage only)*
- `TRIGGERPATH`
- `CLOUD`

For non-PlanNOW implementations, also define:
- `CONTEXTNAMES` *(comma-separated if multiple)*

---

## 📁 Path Configuration

The system expects installation on the `D:` drive.  
If using a different drive or directory, update the following variables in `GlobalVariables.bat`:

- `DSDIR` *(for JI on DataStage only)*
- `QUARTZHOMEPATHS`
- `SFTPPATH`
- `FACTHISTORYPATH`
- `INBOXPATH`
- `INBOXARCHIVEPATH`
- `OUTBOXPATH`
- `RECLASSPATH`
- `SFTPSUPPORTPATH`
- `SQLLDRCONTROLPATH`
- `SQLLDRERRORSPATH`
- `SQLLDRLOGSPATH`
- `STRUCTURELOADERRORSPATH`
- `TYLOADERRORSPATH`

---

## 🛠️ Implementation-Specific Scripts

These files contain implementation-specific configurations such as FTF and Quartz Cube names.  
By default, they are configured for **PlanNOW**:

- `ActualsCubeSync.bat`
- `EPBatchFacility.xml`
- `FoundationActualsDataUpdate.bat`
- `FoundationPlanDataUpdate.bat`
- `GatherSchemaStats.sql`
- `GlobalVariables.bat`
- `PlanCubeSync.bat`
- `PurgeFoundation.bat` *(Optional — in Add-Ons)*
- `PurgeQuartz.bat` *(Optional — in Add-Ons)*
- `QuartzCubeRestructure.bat` *(Optional — in Add-Ons)*
- `QuartzCubeSync.bat`
- `QuartzPurgeAgedData.bat`
- `sftp_support_global_variables.vbs` *(Optional — in `Add-Ons/Cloud SFTP/SFTP_Support`)*

---

## 🌐 Mulesoft Configuration Files

These files are specific to your Mulesoft setup and should be customized per implementation:

- `SetEKBSchemaProperties.json`
- `SetEmailProperties.json`
- `SetEXTSchemaProperties.json`
- `SetFrameworkProperties.json`
- `SetHTTPProperties.json`
- `SetJIProperties.json`

---

## 📄 Notes

- Ensure all paths and values are correctly aligned with your implementation before deployment.
- Optional scripts and configurations should only be deployed when applicable.

---

For more information, refer to the official EP Batch Facility implementation guide or contact your system administrator.
