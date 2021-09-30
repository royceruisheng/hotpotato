/* app/javascript/stylesheets/tailwind.config.js */
module.exports = {
  purge: [
    "./app/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/javascript/**/*.vue",
  ],
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
