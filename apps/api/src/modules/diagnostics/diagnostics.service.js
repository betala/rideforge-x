import { AiDiagnosticsService } from '../../services/aiDiagnosticsService.js';
import { GarageRepository } from '../garage/garage.repository.js';
import { DiagnosticsRepository } from './diagnostics.repository.js';

export class DiagnosticsService {
  constructor(
    repository = new DiagnosticsRepository(),
    ai = new AiDiagnosticsService(),
    garageRepository = new GarageRepository(),
  ) {
    this.repository = repository;
    this.ai = ai;
    this.garageRepository = garageRepository;
  }

  async analyze(userId, data) {
    const motorcycle = await this.garageRepository.findById(userId, data.motorcycleId);
    const analysis = await this.ai.analyze({ motorcycle, symptoms: data.symptoms, obdCodes: data.obdCodes });
    return this.repository.create(userId, data, analysis);
  }
}

