<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>






<title>DEMOGRAPHICS</title>
<style>

table.in_table{  width:100%; border: none;}
table.in_table th{  background: none; padding: 0px; border: none;}
table.in_table td{ padding: 0px; width:63px; text-align:right; border: none;}
table.in_table tr:last-child{ border: none;}


.tb001 td .label_01{ font-size: 12px; line-height:18px; color:#333; display:block; padding:0px 2px 3px 8px; margin-top:-4px; box-sizing: border-box; word-break:break-all; word-wrap:break-word; }
.tb001 td .label_02{ font-size: 11px; line-height:23px; color:#333; display:block; padding:0px 2px 0px 8px; margin-top:-2px; box-sizing: border-box;  word-break:break-all; word-wrap:break-word;}
</style>

<script type="text/javascript">

var testData_01 =[
{
  "MedDRA version for Medical History":"input Q E",
  "Structured information":"input Q E",
  "Start Date Format":"input Q E",
  "Start Date":"input Q E",
  "Continuing":"input Q E",
  "End Date Format":"input Q E",
  "End Date":"input Q E",
  "Comments":"input Q E"
}, {
  "MedDRA version for Medical History":"input Q E",
  "Structured information":"input Q E",
  "Start Date Format":"input Q E",
  "Start Date":"input Q E",
  "Continuing":"input Q E",
  "End Date Format":"input Q E",
  "End Date":"input Q E",
  "Comments":"input Q E"
}];


var myGridOption_01 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_01'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "MedDRA version for Medical History",
    headerText : "MedDRA version for Medical History"
  },{
    dataField : "Structured information",
    headerText : "Structured information"
  },{
    dataField : "Start Date Format",
    headerText : "Start Date Format"
  },{
    dataField : "Start Date",
    headerText : "Start Date"
  },{
    dataField : "Continuing",
    headerText : "Continuing"
  },{
    dataField : "End Date Format",
    headerText : "End Date Format"
  },{
    dataField : "End Date",
    headerText : "End Date"
  },{
    dataField : "Comments",
    headerText : "Comments"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_01);
  }
};



var testData_02 =[
{
	"Name of Drug as Reported":"input Q E",
	"Start Date Format":"input Q E",
	"Start Date":"input Q E",
	"End Date Format":"input Q E",
	"End Date":"input Q E",
	"MedDRA version for indication":"input Q E",
	"Indicaton":"input Q E",
	"MedDRA version For reaction":"input Q E",
	"Reaction":"input Q E"
}, {
	"Name of Drug as Reported":"input Q E",
	"Start Date Format":"input Q E",
	"Start Date":"input Q E",
	"End Date Format":"input Q E",
	"End Date":"input Q E",
	"MedDRA version for indication":"input Q E",
	"Indicaton":"input Q E",
	"MedDRA version For reaction":"input Q E",
	"Reaction":"input Q E"
}];


var myGridOption_02 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_02'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "Name of Drug as Reported",
    headerText : "Name of Drug as Reported"
  },{
    dataField : "Start Date Format",
    headerText : "Start Date Format"
  },{
    dataField : "Start Date",
    headerText : "Start Date"
  },{
    dataField : "End Date Format",
    headerText : "End Date Format"
  },{
    dataField : "End Date",
    headerText : "End Date"
  },{
    dataField : "MedDRA version for indication",
    headerText : "MedDRA version for indication"
  },{
    dataField : "Indicaton",
    headerText : "Indicaton"
  },{
    dataField : "MedDRA",
    headerText : "MedDRA"
  },{
    dataField : "Reaction",
    headerText : "Reaction"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_02);
  }
};


var testData_03 =[
{
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}, {
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}, {
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"

}];



var myGridOption_03 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_03'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "data_01",
    headerText : "data_01"
  },{
    dataField : "data_02",
    headerText : "data_02"
  },{
    dataField : "data_03",
    headerText : "data_03"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_03);
  }
};



var testData_04 =[
{
  "MedDRA version for reported cause(s) of deat":"input Q E",
  "Reported cause(s) of death(repeat as necessary)":"input Q E"
}, {
  "MedDRA version for reported cause(s) of deat":"input Q E",
  "Reported cause(s) of death(repeat as necessary)":"input Q E"
}];



var myGridOption_04 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_04'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "MedDRA version for reported cause(s) of deat",
    headerText : "MedDRA version for reported cause(s) of deat"
  },{
    dataField : "Reported cause(s) of death(repeat as necessary)",
    headerText : "Reported cause(s) of death(repeat as necessary)"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_04);
  }
};



var testData_05 =[
{
  "MedDRA version for autopsy-determined cause(s) of deat":"input Q E",
  "Autopsy-determined cause(s) of death(repeat as necessary)":"input Q E"
}, {
  "MedDRA version for autopsy-determined cause(s) of deat":"input Q E",
  "Autopsy-determined cause(s) of death(repeat as necessary)":"input Q E"
}];




var myGridOption_05 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_05'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "MedDRA version for autopsy-determined cause(s) of deat",
    headerText : "MedDRA version for autopsy-determined cause(s) of deat"
  },{
    dataField : "Autopsy-determined cause(s) of death(repeat as necessary)",
    headerText : "Autopsy-determined cause(s) of death(repeat as necessary)"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_05);
  }
};



var testData_06 =[
{
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}, {
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}, {
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"

}];



var myGridOption_06 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_06'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "data_01",
    headerText : "data_01"
  },{
    dataField : "data_02",
    headerText : "data_02"
  },{
    dataField : "data_03",
    headerText : "data_03"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_06);
  }
};



var testData_07 =[
{
  "MedDRA version for Medical History":"input Q E",
  "Structured information":"input Q E",
  "Start Date Format":"input Q E",
  "Start Date":"input Q E",
  "Continuing":"input Q E",
  "End Date Format":"input Q E",
  "End Date":"input Q E",
  "Comments":"input Q E"
}, {
  "MedDRA version for Medical History":"input Q E",
  "Structured information":"input Q E",
  "Start Date Format":"input Q E",
  "Start Date":"input Q E",
  "Continuing":"input Q E",
  "End Date Format":"input Q E",
  "End Date":"input Q E",
  "Comments":"input Q E"
}];


var myGridOption_07 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_07'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "MedDRA version for Medical History",
    headerText : "MedDRA version for Medical History"
  },{
    dataField : "Structured information",
    headerText : "Structured information"
  },{
    dataField : "Start Date Format",
    headerText : "Start Date Format"
  },{
    dataField : "Start Date",
    headerText : "Start Date"
  },{
    dataField : "Continuing",
    headerText : "Continuing"
  },{
    dataField : "End Date Format",
    headerText : "End Date Format"
  },{
    dataField : "End Date",
    headerText : "End Date"
  },{
    dataField : "Comments",
    headerText : "Comments"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_07);
  }
};





var testData_08 =[
{
  "Name of Drug as Reported":"input Q E",
  "Start Date Format":"input Q E",
  "Start Date":"input Q E",
  "End Date Format":"input Q E",
  "End Date":"input Q E",
  "MedDRA version for indication":"input Q E",
  "Indication":"input Q E",
  "MedDRA version For reaction":"input Q E",
  "Reaction":"input Q E"
}, {
  "Name of Drug as Reported":"input Q E",
  "Start Date Format":"input Q E",
  "Start Date":"input Q E",
  "End Date Format":"input Q E",
  "End Date":"input Q E",
  "MedDRA version for indication":"input Q E",
  "Indication":"input Q E",
  "MedDRA version For reaction":"input Q E",
  "Reaction":"input Q E"
}];


var myGridOption_08 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_08'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "Name of Drug as Reported",
    headerText : "Name of Drug as Reported"
  },{
    dataField : "Start Date Format",
    headerText : "Start Date Format"
  },{
    dataField : "Start Date",
    headerText : "Start Date"
  },{
    dataField : "End Date Format",
    headerText : "End Date Format"
  },{
    dataField : "End Date",
    headerText : "End Date"
  },{
    dataField : "MedDRA version for indication",
    headerText : "MedDRA version for indication"
  },{
    dataField : "Indication",
    headerText : "Indication"
  },{
    dataField : "MedDRA version For reaction",
    headerText : "MedDRA version For reaction"
  },{
    dataField : "Reaction",
    headerText : "Reaction"
  }],

  

  
  
  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_08);
  }
};



var testData_09 =[
{
  "Source Reaction":"input Q E",
  "MedDRA version LLT":"input Q E",
  "Reaction/event in MedDRA":"input Q E",
  "MedDRA version PT":"input Q E",
  "MedDRA term(PT)":"input Q E",
  "MedDRA version for indication":"input Q E",
  "Term highlighted by the reporter":"input Q E",
  "Date of start Format":"input Q E",
  "Date of start":"input Q E",
  "Date of End Format":"input Q E",
  "Date of End":"input Q E",
  "Duration":"input Q E",
  "Duration Unit":"input Q E",
  "First Time":"input Q E",
  "First Time Unit":"input Q E",
  "Last Time":"input Q E",
  "Last Time Unit":"input Q E",
  "Outcome":"input Q E"
}, {
  "Source Reaction":"input Q E",
  "MedDRA version LLT":"input Q E",
  "Reaction/event in MedDRA":"input Q E",
  "MedDRA version PT":"input Q E",
  "MedDRA term(PT)":"input Q E",
  "MedDRA version for indication":"input Q E",
  "Term highlighted by the reporter":"input Q E",
  "Date of start Format":"input Q E",
  "Date of start":"input Q E",
  "Date of End Format":"input Q E",
  "Date of End":"input Q E",
  "Duration":"input Q E",
  "Duration Unit":"input Q E",
  "First Time":"input Q E",
  "First Time Unit":"input Q E",
  "Last Time":"input Q E",
  "Last Time Unit":"input Q E",
  "Outcome":"input Q E"
}];


var myGridOption_09 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_09'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "Source Reaction",
    headerText : "Source Reaction"
  },{
    dataField : "MedDRA version LLT",
    headerText : "MedDRA version LLT"
  },{
    dataField : "Reaction/event in MedDRA",
    headerText : "Reaction/event in MedDRA"
  },{
    dataField : "MedDRA version PT",
    headerText : "MedDRA version PT"
  },{
    dataField : "MedDRA term(PT)",
    headerText : "MedDRA term(PT)"
  },{
    dataField : "MedDRA version for indication",
    headerText : "MedDRA version for indication"
  },{
    dataField : "Term highlighted by the reporter",
    headerText : "Term highlighted by the reporter"
  },{
    dataField : "Date of start Format",
    headerText : "Date of start Format"
  },{
    dataField : "Date of start",
    headerText : "Date of start"
  },{
    dataField : "Date of End Format",
    headerText : "Date of End Format"
  },{
    dataField : "Date of End",
    headerText : "Date of End"
  },{
    dataField : "Duration",
    headerText : "Duration"
  },{
    dataField : "Duration Unit",
    headerText : "Duration Unit"
  },{
    dataField : "First Time",
    headerText : "First Time"
  },{
    dataField : "First Time Unit",
    headerText : "First Time Unit"
  },{
    dataField : "Last Time",
    headerText : "Last Time"
  },{
    dataField : "Last Time Unit",
    headerText : "Last Time Unit"
  },{
    dataField : "Outcome",
    headerText : "Outcome"
  }],


  

  
  
  
  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_09);
  }
};



var testData_10 =[
{
  "Date Format":"input Q E",
  "Date":"input Q E",
  "Name":"input Q E",
  "Result":"input Q E",
  "Unit":"input Q E",
  "Low Stange":"input Q E",
  "High Stange":"input Q E",
  "More Information":"input Q E"
}, {
  "Date Format":"input Q E",
  "Date":"input Q E",
  "Name":"input Q E",
  "Result":"input Q E",
  "Unit":"input Q E",
  "Low Stange":"input Q E",
  "High Stange":"input Q E",
  "More Information":"input Q E"
}];


var myGridOption_10 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_10'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "Date Format",
    headerText : "Date Format"
  },{
    dataField : "Date",
    headerText : "Date"
  },{
    dataField : "Name",
    headerText : "Name"
  },{
    dataField : "Result",
    headerText : "Result"
  },{
    dataField : "Unit",
    headerText : "Unit"
  },{
    dataField : "Low Stange",
    headerText : "Low Stange"
  },{
    dataField : "High Stange",
    headerText : "High Stange"
  },{
    dataField : "More Information",
    headerText : "More Information"
  }],

  
  
  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_10);
  }
};





var testData_11 =[
{
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}, {
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}, {
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"

}];



var myGridOption_11 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_11'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "data_01",
    headerText : "data_01"
  },{
    dataField : "data_02",
    headerText : "data_02"
  },{
    dataField : "data_03",
    headerText : "data_03"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_11);
  }
};






var testData_12 =[
{
  "Proprietary medicinal product name":"ACETYLSALICYLIC ACID W/ASCORBIC ACID",
  "Active Drug substance names":"2222",
  "Batch/lot number":"12345678912345679aaaa",
  "Date of start":"444",
  "Dat of last":"5555"
}, {
  "Proprietary medicinal product name":"ACETYLSALICYLIC ACID W/ASCORBIC ACID",
  "Active Drug substance names":"2222",
  "Batch/lot number":"12345678912345679aaaa",
  "Date of start":"444",
  "Date of last":"5555"
}];



var myGridOption_12 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_12'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "Proprietary medicinal product name",
    headerText : "Proprietary medicinal product name"
  },{
    dataField : "Active Drug substance names",
    headerText : "Active Drug substance names"
  },{
    dataField : "Batch/lot number",
    headerText : "Batch/lot number"
  },{
    dataField : "Date of start",
    headerText : "Date of start"
  },{
    dataField : "Date of last",
    headerText : "Date of last"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_12);
  }
};







var testData_13 =[
{
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}, {
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}, {
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}];



var myGridOption_13 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_13'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "data_01",
    headerText : "data_01"
  },{
    dataField : "data_02",
    headerText : "data_02"
  },{
    dataField : "data_03",
    headerText : "data_03"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_13);
  }
};







var testData_14 =[
{
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}, {
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}, {
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}];



var myGridOption_14 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_14'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "data_01",
    headerText : "data_01"
  },{
    dataField : "data_02",
    headerText : "data_02"
  },{
    dataField : "data_03",
    headerText : "data_03"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_14);
  }
};








$(function() {
	myGridOption_01.createGrid();
	myGridOption_02.createGrid();
	myGridOption_03.createGrid();
	myGridOption_04.createGrid();
	myGridOption_05.createGrid();
	myGridOption_06.createGrid();
	myGridOption_07.createGrid();
	myGridOption_08.createGrid();
	myGridOption_09.createGrid();
	myGridOption_10.createGrid();
	myGridOption_11.createGrid();
	myGridOption_12.createGrid();
	myGridOption_13.createGrid();
	myGridOption_14.createGrid();
	setAccodian();
	
	mkSetDatePickerYYMMDD("#day_01");
	mkSetDatePickerYYMMDD("#day_02");
	mkSetDatePickerYYMMDD("#day_03");
	mkSetDatePickerYYMMDD("#day_04");
	mkSetDatePickerYYMMDD("#day_05");

	
	
});


$(document).ready(function() {
	

	// 팝업레이어
	$('.popup_01').click(function(){
		mkLayerPopupOpen("./_SDBG0104.do", null);
		AUIGrid.resize(myGridOption_001.id);
		AUIGrid.resize(myGridOption_002.id);
		AUIGrid.resize(myGridOption_003.id);
	});

	//$('.popup_01').trigger('click');
	
	
});



$(window).resize(function() {

	if(myGridOption_01.id) {
		AUIGrid.resize(myGridOption_01.id);
	}
	if(myGridOption_02.id) {
		AUIGrid.resize(myGridOption_02.id);
	}
	if(myGridOption_03.id) {
		AUIGrid.resize(myGridOption_03.id);
	}
	if(myGridOption_04.id) {
		AUIGrid.resize(myGridOption_04.id);
	}
	if(myGridOption_05.id) {
		AUIGrid.resize(myGridOption_05.id);
	}
	if(myGridOption_06.id) {
		AUIGrid.resize(myGridOption_06.id);
	}
	if(myGridOption_07.id) {
		AUIGrid.resize(myGridOption_07.id);
	}
	if(myGridOption_08.id) {
		AUIGrid.resize(myGridOption_08.id);
	}
	if(myGridOption_09.id) {
		AUIGrid.resize(myGridOption_09.id);
	}
	if(myGridOption_10.id) {
		AUIGrid.resize(myGridOption_10.id);
	}
	if(myGridOption_11.id) {
		AUIGrid.resize(myGridOption_01.id);
	}
	if(myGridOption_12.id) {
		AUIGrid.resize(myGridOption_12.id);
	}
	if(myGridOption_13.id) {
		AUIGrid.resize(myGridOption_13.id);
	}
	if(myGridOption_14.id) {
		AUIGrid.resize(myGridOption_14.id);
	}

});






function setAccodian(){
	 for(var ai=0; ai<3; ai++){
	    aiP = ai+1;
	
		(function(aiE){ 
			$(".accordion_0"+aiE+" > a").on("click",function() {
				if ($(this).hasClass("close")) {
					$(this).siblings(".accordion_con_0"+aiE+"").slideToggle(20);
					$(this).toggleClass('open');
					//그리드 리사이징
					AUIGrid.resize(myGridOption_01.id);
					AUIGrid.resize(myGridOption_02.id);
					AUIGrid.resize(myGridOption_03.id);
					AUIGrid.resize(myGridOption_04.id);
					AUIGrid.resize(myGridOption_05.id);
					AUIGrid.resize(myGridOption_06.id);
					AUIGrid.resize(myGridOption_07.id);
					AUIGrid.resize(myGridOption_08.id);
					AUIGrid.resize(myGridOption_09.id);
					AUIGrid.resize(myGridOption_10.id);
					AUIGrid.resize(myGridOption_11.id);
					AUIGrid.resize(myGridOption_12.id);
					AUIGrid.resize(myGridOption_13.id);
					AUIGrid.resize(myGridOption_14.id);
				}
			});

			$(".accordion_con_02").css({"display":"none"});
			$(".accordion_con_03").css({"display":"none"});
		
		})(aiP);	
	}
}



</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />
	<form id="iform">
	<input type='hidden' id=''/>							
	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>국외사례리스트</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>국외사례</li>
						<li>국외사례리스트</li>
					</ul>
				</nav>
			</article>




            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">


<br>
<br>
<br>

<style>
.ui-datepicker .ui-datepicker-buttonpane{ display:none;}
</style>

<script type="text/javascript" src="/js/pantheon/common/unified.cubesafety.js"></script>





<div class="dateBox">
	<input type="text" id="" style="width: 130px;" data-datatype="DATE" data-yyuk="Y" data-mmuk="Y" data-dduk="Y" />
</div>



<br>
<br>
<br>



					<div class="button_tab_01">
						<ul>
							<li id="" class="tab_menu">레포트 정보</li>
							<li id="" class="port_back tab_menu">환자정보</li>
						</ul>
					</div>


                    <article class="conTitBtnR">
						<input type="button" id="btnSave" class="btn mgL3" value="초기화">
						<input type="button" id="btnSave" class="btn mgL3" value="저장">
						<input type="button" id="btnDel" class="btn mgL3" value="내역">
                    </article>
					<div style="clear:both; "></div>



	
					<ul class="mgT5">
					    <li class="accordion_02">
					    	<a href="#void" class="close">Patient</a>
					    	
					        <div class="accordion_con_02">
								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="30%" />
										<col width="20%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>Initial</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Medical Record Number</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Specialist Record Number</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Hospital Record Number</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Investigation Number</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Date of birth</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="day_01" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>On Set Age</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>On Set Age Unit</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="" style="width:100%;">
																<option value=''>===selected===</option>
																<option value=''>data</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Gestation period when reaction/event was observed in the fetus</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Gestation period when reaction/event was observed in the fetus unit</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="" style="width:100%;">
																<option value=''>===selected===</option>
																<option value=''>data</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Patient age group</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="" style="width:100%;">
																<option value=''>===selected===</option>
																<option value=''>data</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Weight(kg)</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Height(cm)</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Sex</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="radio" id="a11" name="a1"><label for="a11" class="raLab"><span>Maile</span></label>
															<input type="radio" id="a12" name="a1"><label for="a12" class="raLab"><span>Female</span></label>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Last menstrual period date Format</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="" style="width:100%;">
																<option value=''>===selected===</option>
																<option value=''>data</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Last menstrual period date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</tbody>
								</table>


								<div style="padding:6px; box-sizing: border-box; ">
				                    <article class="conTitBox">
				                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">Relevant medical history and concurrent conditions</h6>
				                    </article>
				                    
				
				                    <article class="conTitBtnR">
				                        <input type="button" id="" value="행추가">
				                        <input type="button" id="" value="행삭제">
				                    </article>
				                    
									<div style="height:10px;"></div>
				
									<div id="grid_wrap_01" class="gridHeiSz02 grid_wrap tb01_2"></div>
								</div>





								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>Text for relevant medical history and concurrent conditions</th>
											<td style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="" rows="2" style="width: 100%;" tabindex="20"></textarea>
														</th>
														<td style="vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" />
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label class="label_01" id=""></label>
											</td>
										</tr>
									</tbody>
								</table>

			






			                    
			                    <div style="padding:6px; box-sizing: border-box; ">
				                    <article class="conTitBox">
				                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">Relevant past drug history (repeat as necessary)</h6>
				                    </article>
				
				                    <article class="conTitBtnR">
				                        <input type="button" id="" value="행추가">
				                        <input type="button" id="" value="행삭제">
				                    </article>
				                    
									<div style="height:10px;"></div>
									
									<div id="grid_wrap_02" class="gridHeiSz02 grid_wrap tb01_2"></div>
								</div>
			                    







					            <ul class="mgT20">
					                <li class="accordion_03">
					                	<a heft="#void" class="close"><span>[Q내역]</span></a>
					                    <div class="accordion_con_03 close">
					                        <div id="grid_wrap_03" class="gridHeiSz03 grid_wrap tb01_2"></div>
					                    </div>
					                </li>
					            </ul>
					        </div>
					    </li>
					    
					    
					    
					    <li class="accordion_02">
					    	<a href="#void" class="close">In case of death</a>

					        <div class="accordion_con_02">

								
								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="30%" />
										<col width="20%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>Date of death Format</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="" style="width:100%;">
																<option value=''>===selected===</option>
																<option value=''>data</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Date of death</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="day_02" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Was autopsy done?</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<input type="radio" id="b11" name="b1"><label for="b11" class="raLab"><span>Yes</span></label>
															<input type="radio" id="b12" name="b1"><label for="b12" class="raLab"><span>No</span></label>
															<input type="radio" id="b13" name="b1"><label for="b13" class="raLab"><span>Unknown</span></label>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</tbody>
								</table>




								<div style=" width:50%; display:inline-block; padding:6px; box-sizing: border-box; ">
				                    <article class="conTitBox">
				                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">Patient Death Cause</h6>
				                    </article>
				                    
				
				                    <article class="conTitBtnR">
				                        <input type="button" id="" value="행추가">
				                        <input type="button" id="" value="행삭제">
				                    </article>
				                    
									<div style="height:10px;"></div>
				
									<div id="grid_wrap_04" class="gridHeiSz02 grid_wrap tb01_2"></div>
								</div>
			                    
			                    
			                    <div style=" width:49.54%; display:inline-block; padding:6px; box-sizing: border-box; ">
				                    <article class="conTitBox">
				                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">Patient Autopsy</h6>
				                    </article>
				
				                    <article class="conTitBtnR">
				                        <input type="button" id="" value="행추가">
				                        <input type="button" id="" value="행삭제">
				                    </article>
				                    
									<div style="height:10px;"></div>
									
									<div id="grid_wrap_05" class="gridHeiSz02 grid_wrap tb01_2"></div>
								</div>
			                    







					            <ul class="mgT20">
					                <li class="accordion_03">
					                	<a heft="#void" class="close"><span>[Q내역]</span></a>
					                    <div class="accordion_con_03 close">
					                        <div id="grid_wrap_06" class="gridHeiSz03 grid_wrap tb01_2"></div>
					                    </div>
					                </li>
					            </ul>
					        </div>
					    </li>
					    
					    
					    
					    
					    <li class="accordion_02">
					    	<a href="#void" class="close">Parent</a>
					    	
					        <div class="accordion_con_02">
								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="30%" />
										<col width="20%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>Parent identification</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
											<th>Age of parent</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Date of birth</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="day_03" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="day_04" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Age of parent Unit</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Weight(kg)</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Last menstrual period date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="day_05" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Sex</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="radio" id="c11" name="c1"><label for="c11" class="raLab"><span>Male</span></label>
															<input type="radio" id="c12" name="c1"><label for="c12" class="raLab"><span>Female</span></label>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Height(cm)</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</tbody>
								</table>


								<div style="padding:6px; box-sizing: border-box; ">
				                    <article class="conTitBox">
				                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">Relevant medical history and concurrent conditions of parent</h6>
				                    </article>
				                    
				
				                    <article class="conTitBtnR">
				                        <input type="button" id="" value="행추가">
				                        <input type="button" id="" value="행삭제">
				                    </article>
				                    
									<div style="height:10px;"></div>
				
									<div id="grid_wrap_07" class="gridHeiSz02 grid_wrap tb01_2"></div>
								</div>





								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>Text for relevant medical history and concurrent conditions of parent(not including reaction/event)</th>
											<td style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="" rows="2" style="width: 100%;" tabindex="20"></textarea>
														</th>
														<td style="vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" />
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label class="label_01" id=""></label>
											</td>
										</tr>
									</tbody>
								</table>

			



			                    
			                    <div style="padding:6px; box-sizing: border-box; ">
				                    <article class="conTitBox">
				                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">Relevant past drug history</h6>
				                    </article>
				
				                    <article class="conTitBtnR">
				                        <input type="button" id="" value="행추가">
				                        <input type="button" id="" value="행삭제">
				                    </article>
				                    
									<div style="height:10px;"></div>
									
									<div id="grid_wrap_08" class="gridHeiSz02 grid_wrap tb01_2"></div>
								</div>
			                    




			                    
			                    <div style="padding:6px; box-sizing: border-box; ">
				                    <article class="conTitBox">
				                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">Reaction</h6>
				                    </article>
				
				                    <article class="conTitBtnR">
				                        <input type="button" id="" value="행추가">
				                        <input type="button" id="" value="행삭제">
				                    </article>
				                    
									<div style="height:10px;"></div>
									
									<div id="grid_wrap_09" class="gridHeiSz02 grid_wrap tb01_2"></div>
								</div>





			                    
			                    <div style="padding:6px; box-sizing: border-box; ">
				                    <article class="conTitBox">
				                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">Test</h6>
				                    </article>
				
				                    <article class="conTitBtnR">
				                        <input type="button" id="" value="행추가">
				                        <input type="button" id="" value="행삭제">
				                    </article>
				                    
									<div style="height:10px;"></div>
									
									<div id="grid_wrap_10" class="gridHeiSz02 grid_wrap tb01_2"></div>
								</div>




					            <ul class="mgT20">
					                <li class="accordion_03">
					                	<a heft="#void" class="close"><span>[Q내역]</span></a>
					                    <div class="accordion_con_03 close">
					                       <div id="grid_wrap_11" class="gridHeiSz03 grid_wrap tb01_2"></div>
					                    </div>
					                </li>
					            </ul>
					        </div>
					    </li>
					    
					    
					    
					    
					    <li class="accordion_02" style="position:relative;">
					    	<a href="#void" class="close">Drug</a>
					    	<span style=" position: absolute; left:60px; top:-1px;"><input type="button" id="" value="Drug 팝업" class="popup_01"></span>

					        <div class="accordion_con_02">
					        	

			                    <div style="padding:6px; box-sizing: border-box; ">
				
				                    <article class="conTitBtnR">
				                        <input type="button" id="" value="행추가">
				                        <input type="button" id="" value="행삭제">
				                    </article>
				                    
									<div style="clear:both; height:10px;"></div>
									
									<div id="grid_wrap_12" class="gridHeiSz02 grid_wrap tb01_2"></div>
								</div>




	
					            <ul class="mgT20">
					                <li class="accordion_03">
					                	<a heft="#void" class="close"><span>[Q내역]</span></a>
					                    <div class="accordion_con_03 close">
					                        <div id="grid_wrap_13" class="gridHeiSz03 grid_wrap tb01_2"></div>
					                    </div>
					                </li>
					            </ul>
					        </div>
					    </li>
					    
					    
					    
					    <li class="accordion_02">
					    	<a href="#void" class="close">Summary</a>

					        <div class="accordion_con_02">
					        	

								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="30%" />
										<col width="20%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>Narrative Include Clinical</th>
											<td colspan="3"  style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="" rows="2" style="width: 100%;" tabindex="20"></textarea>
														</th>
														<td style="vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" />
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label class="label_01" id=""></label>
											</td>
										</tr>
										<tr>
											<th>Reporter's comments</th>
											<td colspan="3" style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="" rows="2" style="width: 100%;" tabindex="20"></textarea>
														</th>
														<td style="vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" />
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label class="label_01" id=""></label>
											</td>
										</tr>
										<tr>
											<th>MedDRA Version for Sender's diagnosis</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Sender Diagnosis</th>
											<td style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="" rows="2" style="width: 100%;" tabindex="20"></textarea>
														</th>
														<td style="vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" />
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label class="label_01" id=""></label>
											</td>
										</tr>
										<tr>
											<th>Sender's comments</th>
											<td colspan="3" style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="" rows="2" style="width: 100%;" tabindex="20"></textarea>
														</th>
														<td style="vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" />
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label class="label_01" id=""></label>
											</td>
										</tr>
									</tbody>
								</table>



	
					            <ul class="mgT20">
					                <li class="accordion_03">
					                	<a heft="#void" class="close"><span>[Q내역]</span></a>
					                    <div class="accordion_con_03 close">
					                        <div id="grid_wrap_14" class="gridHeiSz03 grid_wrap tb01_2"></div>
					                    </div>
					                </li>
					            </ul>
					        </div>
					    </li>
					    
					   
					    
					</ul>






	
				</div>
            </section>

		</div>
	</section>
	</form>
</div>
</body>
</html>