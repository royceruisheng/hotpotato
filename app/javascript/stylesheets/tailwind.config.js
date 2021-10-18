/* app/javascript/stylesheets/tailwind.config.js */
module.exports = {
  purge: {
    content: [
      "./app/**/*.html.erb",
      "./app/helpers/**/*.rb",
      "./app/javascript/**/*.js",
      "./app/javascript/**/*.vue"
    ],
    safelist: [
      'bg-indigo-500',
      'bg-pink-500',
      'bg-blue-500',
      'bg-red-400',
      'bg-purple-500',
      'bg-green-400',
      'bg-yellow-500',
      'bg-gray-300'
    ]
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
    backgroundSize: {
      '200%': '200%',
    },
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
