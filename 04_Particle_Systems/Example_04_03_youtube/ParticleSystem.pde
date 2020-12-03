class ParticleSystem {
  ArrayList<Particle> particles;

  ParticleSystem() {
    particles = new ArrayList<Particle>();
  }

  void run() {

    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.update();
      p.display();

      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  void addParticle() {
    particles.add(new Particle());
  }
}
