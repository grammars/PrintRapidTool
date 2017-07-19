package prt.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import prt.service.TaskService;
import prt.vo.PrtTask;

@Service
public class TaskServiceImpl implements TaskService
{
	private List<PrtTask> taskList = new ArrayList<PrtTask>();
	
	private int taskIdRec = 0;
	
	@Override
	public PrtTask addTask(PrtTask task)
	{
		task.setId(++taskIdRec);
		taskList.add(task);
		System.out.println("当前任务id为:"+task.getId());
		return task;
	}
	
	@Override
	public PrtTask getTask(int taskId)
	{
		for(PrtTask t : taskList)
		{
			if(taskId == t.getId())
			{
				return t;
			}
		}
		return null;
	}


}
