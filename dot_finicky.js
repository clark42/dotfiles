module.exports = {
  options: {
    hideIcon: true
  },
  defaultBrowser: "Google Chrome",
  handlers: [
    {
      match: [
          "*.hermes.com/*",
	  "*.smile-hosting.fr/*",
	  "*.smile-ops.fr/*",
	  "*.smile-ops.net/*",
	  "*.smile.fr/*",
	  "*.smile.eu/*",
	  "*.infra.digital.hermes/*"
      ],
      browser: { 
        name: "Google Chrome",
        profile: "Profile 3", 
      }
    }
  ]
};
