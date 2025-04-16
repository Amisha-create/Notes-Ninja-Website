<jsp:useBean id ="userbean" class="Mypack.Userbean" scope ="page">
</jsp:useBean>

<jsp:setProperty name="userbean" property ="username" value="amisha"/>
<jsp:setProperty name="userbean" property ="age"/>

Name:<jsp:getProperty name="userbean" property ="username"/><br>
Age:<jsp:getProperty name="userbean" property ="age"/><br>