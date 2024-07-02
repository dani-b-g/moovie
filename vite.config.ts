import { fileURLToPath, URL } from 'node:url'
import path from 'path'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
      '@styles': path.resolve(__dirname, 'src/assets/styles'),
      '@icons': path.resolve(__dirname, 'src/assets/icons'),
      '@components': path.resolve(__dirname, 'src/components'),
      '@router': path.resolve(__dirname, 'src/router'),
      '@stores': path.resolve(__dirname, 'src/stores'),
      '@views': path.resolve(__dirname, 'src/views')
    }
  }
})
