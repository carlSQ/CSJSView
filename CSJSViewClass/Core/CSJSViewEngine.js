var global = this;

(function() {



    var modules = {};
    function Module (path) {
      return {
          path: path,
          load: nativeLoadJSModule,
          exports: {},
          loaded: false
      }
    }

    function require(path) {
        var cacheModule = modules[path];
        if (cacheModule) {
            return cacheModule.exports;
        }

        return requireImpl(path);
    }

    function requireImpl(path) {

        var module = Module(path);
        modules[path] = module;
        try {

            module.load.call(global,global,require, module, module.exports, path);
            module.loaded = true;

         } catch(e) {
            module.loaded = false;
            delete modules[path];
        }

        return module.exports;
    }

    global.require = require;


    var ObjectPool = {};

    var unqua = 0;

    ObjectMemory = {

        getObject: function(address) {
            return ObjectPool[address];
        },

        releaseObject: function(address) {
            delete ObjectPool[address];
        },

        retainObject: function(object) {
            var address = '0x'+ (unqua++);
            ObjectPool[address] = object;
            return address;
        }
 
    };

    global.ObjectMemory = ObjectMemory;

    var registerModules = {};
    ModulesRegistry = {

        registerModule: function(moduleName, module) {
            registerModules[moduleName] = {
                run: function(initParameters) {
                        var moduleInstance  = new module(initParameters);
                      return global.ObjectMemory.retainObject(moduleInstance);
                     }
            };
         },
        getModuleNames: function() {
            return Object.keys(registerModules);
        },

        runApplication: function(moduleName, path, initParameters) {
            if (registerModules[moduleName]) {
               return registerModules[moduleName].run(initParameters);
            } else {
                requireImpl(path);
               return registerModules[moduleName].run(initParameters);
            }
        }

    };

    global.ModulesRegistry = ModulesRegistry;
 

    class CSJSViewController {

        constructor(initParameters) {
            this.initParameters = initParameters;
        }

        viewDidLoad() {
        }

        viewWillAppear(animated) {
        }

        viewDidAppear(animated) {
        }

        viewWillDisappear(animated) {
        }

        viewDidDisappear(animated) {
        }

        didReceiveMemoryWarning() {
        }

    }
    var module = {
                    path: 'CSJSViewController',
                    exports: CSJSViewController,
                    loaded: true
                  };

    modules['CSJSViewController'] = module;

 
}) ();

