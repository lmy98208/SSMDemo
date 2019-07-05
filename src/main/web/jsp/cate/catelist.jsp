<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 2019/7/5
  Time: 22:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>分类表</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=basePath%>static/plugin/layui/css/layui.css">
</head>
<body>

<table id="demo" lay-filter="category"></table>

<!-- 你的HTML代码 -->

<script src="<%=basePath%>static/plugin/layui/layui.js"></script>
<script>
    //一般直接写在一个js文件中
    layui.use(['layer', 'form','table','jquery'], function(){
        var layer = layui.layer,
            form = layui.form,
            table=layui.table,
            $=layui.jquery;


        table.render({
            elem: '#demo'
            ,height: 312
            ,url: '<%=basePath%>cate/list' //数据接口
            ,page: true //开启分页
            ,limit:2
            ,cols: [[ //表头
                {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
                ,{field: 'category', title: '分类名称', width:180}
                ,{field: 'remark', title: '备注', width:200}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
            ]]
        });
        //  layer.msg('Hello World');


        //监听行工具事件
        table.on('tool(category)', function(obj){
            var data = obj.data;
            console.log(data)
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){

                    $.ajax({
                        url:'<%=basePath%>cate/delete',
                        data:{id:data.id},
                        type:'post',
                        dataType:'JSON',
                        success:function (d) {
                            if (d.code=='10000')
                            {
                                obj.del();
                            }
                            else{
                                layer.alert("删除失败，你联系管理员");
                            }
                        },
                        complete:function () {
                            layer.close(index);
                        }
                    })
                });
            } else if(obj.event === 'edit'){
                layer.prompt({
                    formType: 2
                    ,value: data.email
                }, function(value, index){
                    obj.update({
                        email: value
                    });
                    layer.close(index);
                });
            }
        });
    });
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


</body>
</html>
