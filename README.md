# StaticTableViewDatasource
![Swift](https://github.com/EcolabCompany/StaticTableViewDatasource/workflows/Swift/badge.svg?branch=master)

### Overview
Quickly build static tableviews programmatically for iOS

### Installation
- Via Cocoapods

 ```
pod StaticTableViewDatasource
```

### Instructions
- First, create an instance of a StaticTableViewDatasource

 ```
 var datasource = StaticTableViewDatasource()

 ```
 
- Then, create a section with an optional header and footer title

 ```
 datasource.addSection("Section Title", footer: "Section Footer") { section in
 	
 }
 ```
 
- For each section, you can add cells by calling 

 ```
 section.addCell({
     let cell = UITableViewCell()
     cell.textLabel?.text = "This cell has no action associated with it"
     return cell
})
```

- You can also set an action if a cell is selected

 ```
section.addCell({
    let cell = UITableViewCell()
    cell.textLabel?.text = "This cell has an action associated with it"
    return cell
}, didSelect: { 
    print("Cell Selected")
})
```

### Example
```
datasource.addSection(nil) { section in
  section.addCell({
    	let cell = UITableViewCell()
    	cell.textLabel?.text = "This is the First Cell"
	return cell
   })
}

datasource.addSection("2nd Section Title", footer: "2nd Section Footer") { section in
    section.addCell({
        let cell = UITableViewCell()
     	cell.textLabel?.text = "This cell has no action associated with it"
    	return cell
    })

    section.addCell({
        let cell = UITableViewCell()
   	cell.textLabel?.text = "This cell has an action associated with it"
     	return cell
    }, didSelect: { 
    	print("Cell Selected")
    })
}
```

        
 
