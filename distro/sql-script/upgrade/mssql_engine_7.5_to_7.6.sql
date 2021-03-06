-- AUTHORIZATION --

-- add grant authorizations for group camunda-admin:
INSERT INTO
  ACT_RU_AUTHORIZATION (ID_, TYPE_, GROUP_ID_, RESOURCE_TYPE_, RESOURCE_ID_, PERMS_, REV_)
VALUES
  ('camunda-admin-grant-drd', 1, 'camunda-admin', 14, '*', 2147483647, 1);

-- decision requirements definition --

ALTER TABLE ACT_RE_DECISION_DEF
  ADD DEC_REQ_ID_ nvarchar(64);
  
ALTER TABLE ACT_RE_DECISION_DEF
  ADD DEC_REQ_KEY_ nvarchar(255);

ALTER TABLE ACT_RU_CASE_SENTRY_PART
  ADD VARIABLE_EVENT_ nvarchar(255);

ALTER TABLE ACT_RU_CASE_SENTRY_PART
  ADD VARIABLE_NAME_ nvarchar(255);

create table ACT_RE_DECISION_REQ_DEF (
    ID_ nvarchar(64) NOT NULL,
    REV_ int,
    CATEGORY_ nvarchar(255),
    NAME_ nvarchar(255),
    KEY_ nvarchar(255) NOT NULL,
    VERSION_ int NOT NULL,
    DEPLOYMENT_ID_ nvarchar(64),
    RESOURCE_NAME_ nvarchar(4000),
    DGRM_RESOURCE_NAME_ nvarchar(4000),
    TENANT_ID_ nvarchar(64),
    primary key (ID_)
);

alter table ACT_RE_DECISION_DEF
    add constraint ACT_FK_DEC_REQ
    foreign key (DEC_REQ_ID_)
    references ACT_RE_DECISION_REQ_DEF(ID_);

create index ACT_IDX_DEC_DEF_REQ_ID on ACT_RE_DECISION_DEF(DEC_REQ_ID_);
create index ACT_IDX_DEC_REQ_DEF_TENANT_ID on ACT_RE_DECISION_REQ_DEF(TENANT_ID_);

ALTER TABLE ACT_HI_DECINST
  ADD ROOT_DEC_INST_ID_ nvarchar(64);
  
ALTER TABLE ACT_HI_DECINST
  ADD DEC_REQ_ID_ nvarchar(64);
  
ALTER TABLE ACT_HI_DECINST
  ADD DEC_REQ_KEY_ nvarchar(255);
  
create index ACT_IDX_HI_DEC_INST_ROOT_ID on ACT_HI_DECINST(ROOT_DEC_INST_ID_);
create index ACT_IDX_HI_DEC_INST_REQ_ID on ACT_HI_DECINST(DEC_REQ_ID_);
create index ACT_IDX_HI_DEC_INST_REQ_KEY on ACT_HI_DECINST(DEC_REQ_KEY_);

-- CAM-5914
create index ACT_IDX_JOB_EXECUTION_ID on ACT_RU_JOB(EXECUTION_ID_);
create index ACT_IDX_JOB_HANDLER on ACT_RU_JOB(HANDLER_TYPE_,HANDLER_CFG_);

ALTER TABLE ACT_RU_EXT_TASK
  ADD ERROR_DETAILS_ID_ nvarchar(64);

alter table ACT_RU_EXT_TASK
  add constraint ACT_FK_EXT_TASK_ERROR_DETAILS
  foreign key (ERROR_DETAILS_ID_)
  references ACT_GE_BYTEARRAY (ID_);