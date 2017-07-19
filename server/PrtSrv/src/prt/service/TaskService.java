package prt.service;

import prt.vo.PrtTask;

public interface TaskService
{
	PrtTask addTask(PrtTask task);
	
	PrtTask getTask(int taskId);
}
