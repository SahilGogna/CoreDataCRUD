
import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        createData()
//        updateData()
        deleteData()
        retrieveData()
    }
    
    func createData() {
        
//        The process of adding the records to Core Data has following tasks
//        Refer to persistentContainer from appdelegate
//        Create the context from persistentContainer
//        Create an entity with User
//        Create new record with this User Entity
//        Set values for the records for each key
        
        guard let appDelagate = UIApplication.shared.delegate as? AppDelegate else{return}
        let managedContext = appDelagate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext)
        for i in 1...5 {
            let user = NSManagedObject(entity: userEntity!, insertInto: managedContext)
            user.setValue("Sahil\(i)", forKeyPath :"username")
            user.setValue("sahil\(i)", forKeyPath :"password")
            user.setValue("sahil\(i)@test.com", forKeyPath :"email")
        }
        do{
            try managedContext.save()
        } catch let error as NSError{
            print("Could not save \(error)")
        }
    }
    
    func retrieveData() {
        
        //As we know that container is set up in the AppDelegates o we need to efer the container
        guard let appDelagate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        //we need to create a ontext from this container
        let managedContext = appDelagate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                print(data.value(forKey: "username") as! String)
            }
        } catch {
            print("Failed")
        }
    }
    
    func updateData() {
        
        //As we know that container is set up in the AppDelegates o we need to efer the container
        guard let appDelagate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        //we need to create a ontext from this container
        let managedContext = appDelagate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Users")
        
        fetchRequest.predicate = NSPredicate(format: "username = %@", "Sahil5")
        
        do{
            let test = try managedContext.fetch(fetchRequest)
            for i in 0...test.count-1{
                let objectUpdate = test[i] as! NSManagedObject
                objectUpdate.setValue("testname \(i)", forKey: "username")
                objectUpdate.setValue("testemail \(i)", forKey: "email")
                objectUpdate.setValue("testPassword \(i)", forKey: "password")
            }
            do{
                try managedContext.save()
            } catch{
                print(error)
            }
            
        } catch{
            print(error)
        }
    }
    
    func deleteData(){
        //As we know that container is set up in the AppDelegates so we need to refer the container
        guard let appDelagate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        //we need to create a ontext from this container
        let managedContext = appDelagate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Users")
        
        fetchRequest.predicate = NSPredicate(format: "username = %@", "Sahil3")
        
        do{
            let test = try managedContext.fetch(fetchRequest)
            for i in 0...test.count-1{
                let objectDelete = test[i] as! NSManagedObject
                managedContext.delete(objectDelete)
            }
            do{
                try managedContext.save()
            } catch{
                print(error)
            }
            
        } catch{
            print(error)
        }
        
    }
}

