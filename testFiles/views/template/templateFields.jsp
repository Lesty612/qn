<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>编辑工单自定义分类</title>
    <%@include file="/views/include/pageHeader.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/css/selfField.css">
	<%--<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/css/userField.css">--%>
</head>
<body>
	<div class="container-fluid" data-ps-id="0d023947-837c-712b-ae7b-616bac5e0197">
        <ul class="breadcrumbs">
            <li>
                <a target="_self" href="<%=request.getContextPath()%>/workTemplate/workTemplates">工单自定义分类</a>
            </li>
            <li>编辑:[${template.tempName}]</li>
        </ul>
        <div class="panel">
			<div class="kf5-section">
				<div class="field t-col">
					<h4 class="ln">显示标题（客服）</h4>
					<div class="t-col-content">
						<input type="text" value="${template.tempName}" maxlength="255" id="tempName" name="tempName">						
						<a onclick="formSubmit();" class="btn-sm btn-green fr" target="_self">提交</a> 
					</div>					
				</div>
		    </div>
			
			<div class="kf5-section">
				<header class="kf5-list-header">
					<h3>启用的字段（${size1}）</h3>
					<a role="button" class="btn-sm green fr" href="<%=request.getContextPath()%>/workTemplate/fieldType?tempId=${tempId}"
						target="_self">添加新的自定义字段</a>
				</header>
				<ul id="field_list" class="kf5-list1 move">
					<c:forEach items="${activeList}" var="item">
						<li>
							<div id="${item.key}" class="col-md-3">${item.name}</div>
							<div class="col-md-2 undertint">${item.defineType}</div>
							<div class="col-md-2 undertint">${item.componentTypeStr}</div>
							<div class="col-md-2 undertint">${item.isRequiredStr}</div>
							<div class="col-md-3">
							
							<c:choose>
                               <c:when test="${item.editable==false}">
                                   <a class="btn-sm fr" target="_self">无法编辑</a> 
                               </c:when>                          
                               <c:when test="${item.editable==true}">
                                   <a class="btn-sm fr" href="<%=request.getContextPath()%>/field/edit?key=${item.key}&tempId=${item.tempId}" target="_self">编辑</a> 
                               </c:when>  		                            						                               
							</c:choose>
							
							<c:choose>                                                       
                               <c:when test="${item.statusChange==true}">
                                   <a onclick="model_change('deactive','${item.key}');" class="btn-sm danger fr" href="javascript:void(0);" target="_self">停用</a>
                               </c:when>	
                            </c:choose>
                  						   									
							</div> <input type="hidden" value="${item.key}" class="item-field-id">
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="kf5-section">
				<header class="kf5-list-header">
					<h3>未启用的字段（${size2}）</h3>
				</header>
				<ul class="kf5-list1 undertint">
					<c:forEach items="${deactiveList}" var="item">
						<li>
							<div class="col-md-3">${item.name}</div>
							<div class="col-md-2">${item.defineType}</div>
							<div class="col-md-2 undertint">${item.componentTypeStr}</div>
							<div class="col-md-2">${item.isRequiredStr}</div>
							<div class="col-md-3">
								<a class="btn-sm fr" href="<%=request.getContextPath()%>/field/edit?key=${item.key}&tempId=${item.tempId}" target="_self">编辑</a>
								<a onclick="model_change('active','${item.key}');" class="btn-sm fr success"
									href="javascript:void(0);" target="_self">启用</a> <a
									onclick="model_change('delete','${item.key}');" class="btn-sm fr danger"
									href="javascript:void(0);" target="_self">删除</a>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="ps-scrollbar-x-rail">
			<div class="ps-scrollbar-x"></div>
		</div>
		<div class="ps-scrollbar-y-rail">
			<div class="ps-scrollbar-y"></div>
		</div>
	</div>

	<%--<script src="<%=request.getContextPath()%>/script/userField/all.min.js" type="text/javascript"></script>--%>
	<script src="<%=request.getContextPath()%>/script/lib/jquery.drag.js" type="text/javascript"></script>
	<%--<script src="<%=request.getContextPath()%>/script/userField/min.js" type="text/javascript"></script>--%>
	
	<script type="text/javascript">
		//启用，停用，删除
		function model_change(type,key){
			var url = "<%=request.getContextPath()%>/field/change/"+type+"/"+key;
			if (type != "delete" || confirm("确定要删除该工单字段吗？删除后不可恢复！")){
				$.post(url,null,changeCallBack,'json');
			}
		}
		function changeCallBack(data){
			if(data.success){
				notice.success(data.msg);
			}else{
				notice.warning(data.msg);
			}
			location.reload();
		}
		//拖拽排序，并自动提交
		function setDragSort(sortCtner,sortItems,handle,saveSort){
		    if(sortCtner.length&&sortItems.length>=2){
		        var dragStart=false,
		            copy=null,
		            swapNode=function(node1,node2){
		                var tmpNode=document.createTextNode("");
		                node1=node1.get(0);
		                node2=node2.get(0);
		                node1.parentNode.replaceChild(tmpNode,node1);
		                node2.parentNode.replaceChild(node1,node2);
		                tmpNode.parentNode.replaceChild(node2,tmpNode);
		            };
		        sortItems.drag("start",function(event,element){
		            if((sortCtner.attr("id")=="field_list"&&sortCtner.hasClass("move")) || sortCtner.attr("id")!="field_list"){
		                if(event.target.tagName.toLowerCase()!="a"){
		                    dragStart=true;
		                    var that=$(this);
		                    that.addClass("hover");
		                    that.css({position:"absolute",left:"0px",right:"0px"});
		                    copy=$("<li></li>");
		                    copy.css({height:"28px"});
		                    that.after(copy);
		                }
		            }
		        }).drag(function(event,element){
		            if(dragStart){
		                var that=$(this),
		                    index=that.index(),
		                    top=element.offsetY,
		                    minTop=0,
		                    maxTop=46*(sortItems.length-1),
		                    toTop=0;
		                top=Math.max(top,minTop);
		                top=Math.min(top,maxTop);
		                toTop=top;
		                that.css({top:top+"px","z-index":10});
		                sortItems.not(that).each(function(){
		                    var sIndex=$(this).index(),
		                        sTop=$(this).position().top,
		                        sMinTop=sTop-23,
		                        sMaxTop=sTop+23;
		                    if(toTop>sMinTop&&toTop<sMaxTop){
		                        if(toTop>sTop){
		                            $(this).before(copy);
		                        }else{
		                            $(this).after(copy);
		                        }
		                    }
		                });
		            }
		        },{
		            relative:true,
		            handle:handle
		        }).drag("end",function(event,element){
		            if(dragStart){
		                var that=$(this);
		                sortItems.css({position:"relative",top:"0px",left:"0px",right:"0px","z-index":1});
		                sortItems.removeClass("hover");
		                swapNode(copy,that);
		                copy.remove();
		                saveSort();
		                dragStart=false;
		            }
		        });
		    }
		}

		var sortCtner=$("#field_list.move"),
		    sortItems=$("#field_list.move").children(),
		    handle=sortItems.add(sortItems.find("*")),
		    idInputStr=".item-field-id";
		setDragSort(sortCtner,sortItems,handle,function(){
		    var ids = "";
		    sortCtner.find(idInputStr).each(function(){
		        ids += $(this).val()+",";
		    });
		    var tempId = "${tempId}";
		    $.post("<%=request.getContextPath()%>/field/ajax/",{type:"sort",ids:ids,tempId:tempId},function(data){
		    	if(data.success){
					notice.success(data.msg);
				}else{
					notice.warning(data.msg);
				}
				location.reload();
		    });
		});
		
		/* 修改模板标题 */
		function formSubmit(){					
			var param = {};
			param.tempId = "${template.tempId}";
			param.tempName = $("#tempName").val(); 	
			$.post("<%=request.getContextPath()%>/workTemplate/goEdit", param, changeTempCallBack,'json');
		}
		/* 修改模板信息回调函数 */
		function changeTempCallBack(data){
			if(data.success){
				notice.success(data.msg);
			}else{
				notice.warning(data.msg);
				return ;
			}
			location.href="<%=request.getContextPath()%>/workTemplate/workTemplates"; 
		}
		
	</script>
</body>
</html>
