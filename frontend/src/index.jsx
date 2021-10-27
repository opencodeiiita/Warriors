import React from 'react'
import ReactDOM from 'react-dom'
import { ChainId, DAppProvider } from '@usedapp/core'
import { App } from './App'

const config = {
  readOnlyChainId: ChainId.Mumbai,
  readOnlyUrls: {
    [ChainId.Mumbai]: 'https://rpc-mumbai.maticvigil.com',
    [ChainId.Polygon]: 'https://polygon-rpc.com',
    [ChainId.Localhost]: 'http://localhost:8545'
  },
}

ReactDOM.render(
  <React.StrictMode>
    <DAppProvider config={config}>
      <App />
    </DAppProvider>
  </React.StrictMode>,
  document.getElementById('root')
)
