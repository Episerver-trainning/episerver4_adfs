using System;
using System.Collections;

namespace development.Templates.Workrooms.Core
{
	public class WorkroomTemplateCollection : CollectionBase
	{
		public WorkroomTemplateCollection()
		{

		}

		/// <summary>
		/// Gets or sets the WorkroomTemplate associated with the specified index.
		/// </summary>
		public WorkroomTemplate this[int index]
		{
			get
			{
				return (WorkroomTemplate)List[index];
			}
			set
			{
				List[index]=value;
			}
		}

		/// <summary>
		/// Adds an WorkroomTemplate to the end of the collection.
		/// </summary>
		/// <param name="instance">The WorkroomTemplate to be added to the end of the collection.</param>
		public void Add(WorkroomTemplate instance)
		{
			List.Add(instance);
		}

		/// <summary>
		/// Adds an collection of objects to the end of the collection.
		/// </summary>
		/// <param name="instances">The WorkroomTemplateCollection to be added to the end of the collection.</param>
		public void AddRange(WorkroomTemplateCollection instances)
		{
			InnerList.AddRange(instances);
		}

		/// <summary>
		/// Determines whether the collection contains a specific element.
		/// </summary>
		/// <param name="instance">The WorkroomTemplate to locate in the WorkroomTemplateCollection.</param>
		/// <returns>true if the collection contains the specified value; otherwise, false.</returns>
		public bool Contains(WorkroomTemplate instance)
		{
			return List.Contains(instance);
		}

		/// <summary>
		/// Removes the first occurrence of a specific WorkroomTemplate from the collection.
		/// </summary>
		/// <param name="instance">The WorkroomTemplate to remove from the collection.</param>
		public void Remove(WorkroomTemplate instance)
		{
			List.Remove(instance);
		}
		
		/// <summary>
		/// Searches for the specified WorkroomTemplate and returns the zero-based index of the first occurrence within the entire collection.
		/// </summary>
		/// <param name="instance">The WorkroomTemplate to locate in the WorkroomTemplateCollection.</param>
		/// <returns>The zero-based index of the first occurrence of value within the entire collection, if found; otherwise, -1.</returns>																					  
		public int IndexOf(WorkroomTemplate instance)
		{
			return List.IndexOf(instance);
		}

		/// <summary>
		/// Inserts an element into the collection at the specified index.
		/// </summary>
		/// <param name="index">The zero-based index at which value should be inserted.</param>
		/// <param name="instance">The WorkroomTemplate to insert.</param>
		public void Insert(int index,WorkroomTemplate instance)
		{
			List.Insert(index,instance);
		}

		/// <summary>
		/// Copies the entire collection to a one-dimensional array, starting at the specified index of the target array.
		/// </summary>
		/// <param name="instances">The one-dimensional array that is the destination of the elements copied from the collection. The array must have zero-based indexing.</param>
		/// <param name="index">The zero-based index in array at which copying begins.</param>
		public void CopyTo(WorkroomTemplate []instances,int index)
		{
			List.CopyTo(instances,index);
		}
	}

}
