//
//  SwiftWSServer.swift
//  SwiftExamples
//
//  Created by Zeljko Marinkovic on 19/11/2024.
//

import Network
import SwiftUI

class SwiftWSServer {
    let listener: NWListener
    var connectedClients: [NWConnection] = []
    
    init() {
        let tlsOptions = NWProtocolTLS.Options()
        let parameters = NWParameters(tls: tlsOptions)
        let wsOptions = NWProtocolWebSocket.Options()
        wsOptions.autoReplyPing = true
        parameters.defaultProtocolStack.applicationProtocols.insert(wsOptions, at: 0)
        do {
            listener = try NWListener(using: parameters, on: 8000)
            let serverQueue = DispatchQueue(label: "serverQueue")
            
            listener.newConnectionHandler = { newConnection in
                self.connectedClients.append(newConnection)
                newConnection.start(queue: serverQueue)
                
                func receive() {
                    newConnection.receiveMessage { (data, context, isComplete, error) in
                        if let data = data, let context = context {
                            self.handleMessage(data: data, context: context)
                            receive()
                        }
                    }
                }
                receive()
            }
        } catch {
            fatalError()
        }
    }
    
    func sendResponse(items: [Data]) throws {
        let data = try JSONEncoder().encode(items)
        
        for client in connectedClients {
            let metadata = NWProtocolWebSocket.Metadata(opcode: .binary)
            let context = NWConnection.ContentContext(identifier: "context", metadata: [metadata])
            
            client.send(content: data,
                        contentContext: context,
                        isComplete: true,
                        completion: .contentProcessed({ _ in }))
        }
    }
    
    func handleMessage(data: Data, context: NWConnection.ContentContext) {}
}
