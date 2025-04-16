package Mypack;

import java.io.*;
public class Userbean implements Serializable
{
	private String username;
	private int age;

	public void setUsername(String username)
	{
	 	this.username = username;
	}
	public String getUsername()
	{
	 	return username;
	}

	public void setAge(int age)
	{
	 	this.age = age;
	}
	public int getAge()
	{
	 	return age;
	}


}