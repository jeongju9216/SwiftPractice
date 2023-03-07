import Foundation

class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    
    init(value: T) {
        self.value = value
    }
}

struct DoublyLinkedList<T> {
    typealias Node = LinkedListNode<T>
    
    private var head: Node?
    private var tail: Node?
    var count: Int = 0
    
    var isEmpty: Bool {
        return (head == nil)
    }
    
    var first: Node? {
        return head
    }
    
    var last: Node? {
        return tail
    }
    
    //MARK: - Read
    subscript(index: Int) -> T? {
        return node(at: index)?.value
    }
    
    func node(at index: Int) -> Node? {
        guard index >= 0, index < count else {
            fatalError("범위 밖의 index")
        }
        
        if index == 0 {
            return head
        } else if index == count - 1 {
            return tail
        } else {
            var node: Node? = nil
            
            if index < count / 2 {
                node = head!.next
                for _ in 1..<index {
                    node = node!.next
                }
            } else {
                node = tail!.previous
                for _ in (index + 2)..<count {
                    node = node!.previous
                }
            }
            
            return node
        }
    }
    
    //MARK: - Insert
    mutating func append(_ value: T) {
        let newNode = Node(value: value)
    
        if let prevTail = tail {
            //이미 노드가 있던 경우 맨 뒤에 삽입
            prevTail.next = newNode
            newNode.previous = prevTail
            tail = newNode
        } else {
            //노드가 비어있던 경우
            head = newNode
            tail = newNode
        }
        
        count += 1
    }
    
    mutating func insert(_ value: T, at index: Int) -> Bool {
        let newNode = Node(value: value)
        
        if index == 0 {
            newNode.next = head
            head?.previous = newNode
            head = newNode
            
            count += 1
        } else if index == count - 1 {
            append(value)
        } else {
            guard let prevNode = node(at: index - 1) else {
                return false
            }
            let nextNode = prevNode.next
            
            prevNode.next = newNode
            newNode.previous = prevNode
            
            newNode.next = nextNode
            nextNode?.previous = newNode
            
            count += 1
        }
        
        return true
    }
    
    //MARK: - Remove
    mutating func remove(_ index: Int) -> T? {
        guard let removeNode = node(at: index) else {
            return nil
        }
        
        return remove(node: removeNode)
    }

    mutating func remove(node: Node) -> T {
        let nextNode = node.next
        let prevNode = node.previous
        
        if let prevNode = prevNode {
            prevNode.next = nextNode
        } else {
            head = nextNode
        }
        
        if nextNode == nil {
            tail = prevNode
        }
        nextNode?.previous = prevNode
        
        node.next = nil
        node.previous = nil
        
        return node.value
    }
    
    mutating func removeAll() {
        head = nil
        tail = nil
    }
}

extension DoublyLinkedList: CustomStringConvertible {
    var description: String {
        var str = "["
        var cur = head
        
        while let node = cur {
            str += "\(node.value)"
            
            cur = node.next
            if cur != nil {
                str += ", "
            }
        }
        
        return str + "]"
    }
}


var doublyLinkedList = DoublyLinkedList<Int>()
print(doublyLinkedList)

doublyLinkedList.append(1)
doublyLinkedList.append(2)
doublyLinkedList.append(3)
print(doublyLinkedList) //[1, 2, 3]

print(doublyLinkedList[0]) //Optional(1)
print(doublyLinkedList[1]) //Optional(2)
print(doublyLinkedList[2]) //Optional(3)
//print(doublyLinkedList[3]) //Fatal error: 범위 밖의 index

doublyLinkedList.remove(1)
print(doublyLinkedList) //[1, 3]

doublyLinkedList.insert(4, at: 1)
print(doublyLinkedList) //[1, 4, 3]

doublyLinkedList.removeAll()
print(doublyLinkedList) //[]
