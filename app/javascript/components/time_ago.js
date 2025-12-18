
class TimeAgo extends HTMLElement {
  constructor() {
    super();
  }
  connectedCallback() {
    console.log('connected custom component');
    console.log(this.closest(".activite-label").dataset.timeCreated);
    this.updateTime();
    this.intervalId = setInterval(() => {
      console.log('30-second update triggered');
      this.updateTime();
    }, 30000); 
  }

  disconnectedCallback() {
    // Clean up interval when element is removed
    if (this.intervalId) {
      clearInterval(this.intervalId);
      console.log('Interval cleared');
    }
  }

  updateTime() {
    const timeCreated = this.closest(".activite-label")?.dataset.timeCreated;
    const timeNow = this.closest(".activite-label")?.dataset.timeNow;

    if (!timeCreated) return;
    
    const past = Date.parse(timeCreated);
    const now = Date.parse(timeNow);
    const diffMs = now - past;
    this.textContent = this.calculateTime(diffMs);
  }


  calculateTime(diffMs) {
    const seconds = Math.floor(diffMs / 1000);
    const minutes = Math.floor(seconds / 60);
    const hours = Math.floor(minutes / 60);
    const days = Math.floor(hours / 24);
    const months = Math.floor(days / 30);
    const years = Math.floor(days / 365);
    
    if (years > 0) {
      return years === 1 ? '1 year ago' : `${years} years`;
    }
    if (months > 0) {
      if (months > 11) return '1 year ago';
      return months === 1 ? '1 month' : `${months} months`;
    }
    if (days > 0) {
      if (days > 30) return '1 month';
      return days === 1 ? '1 day' : `${days} days`;
    }
    if (hours > 0) {
      if (hours > 23) return '1 day';
      return hours === 1 ? '1 h' : `${hours} h`;
    }
    if (minutes > 0) {
      if (minutes > 59) return '1 h';
      return minutes === 1 ? '1 min' : `${minutes} min`;
    }
    return seconds < 30 ? 'Just now' : `${seconds} sec`;
  }
}

customElements.define("time-ago",  TimeAgo)