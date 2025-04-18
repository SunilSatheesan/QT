# Qt QML Sample Projects 🚀

This repository contains a collection of Qt QML sample projects that I created while learning Qt QML. Each project focuses on specific features or concepts, ranging from basic UI elements to animations, state machines, and integrations with C++.

---

## 🛠️ Technologies Used

- Qt 6
- QML (Qt Modeling Language)
- Qt Quick Controls
- C++ 
- Qt Creator / CMake

---

## 📦 How to Run

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/qt-qml-samples.git
   cd qt-qml-samples

2. Open in QT creator, build and run.

---

## 📚 Learnings Table

| Project Name    	| Concept	| Learning						| Example					|
| ----------------- | ---------	| ----------------------------- | -------------------------	|
| Login with Dashboard		| 	 `setContextProperty` or `qmlRegisterType`   	| - `setContextProperty` creates the object in the main.cpp file itself, hence object is initialized already and starts it's executions i.e., specified in it's constructor, on the other hand `qmlRegisterType` just registers the cpp class as a qml type and does not create the object, qml has the resposibility to initialize it. <br><br>- If it is a global object to be used in all qml files with maybe static values then we could use `setContextProperty`, as with `qmlRegisterType` object is initialized when used in qml and object gets destructed when the qml is unloaded, and then created again if the qml is loaded again| ```MockBackend backendData;
engine.rootContext()->setContextProperty("backendData", &backendData);
qmlRegisterType<MockBackend>("demo", 1, 0, "MockBackend");```<br>- `MockBacked` was a class which was used only in a QML file which shows the home page	and in it's contructor it was generating a dummy data every 2 seconds, so using `setContextProperty` was causing the object to initialize as soon as application engine calls it and constructor executes until the app is closed, but it was needed only when home page is loaded, so here we would need to use `qmlRegisterType' and initialze it in the home page qml and ocntructor of the class runs only when home page is loaded and object is destroyed when home page qml is unloaded.|
| 			| 	     	|								|							|
| 	    			| 	    	|								|							|


---
