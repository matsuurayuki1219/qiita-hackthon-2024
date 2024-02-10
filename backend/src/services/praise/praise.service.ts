import { Injectable } from '@nestjs/common';
import { Praise } from 'src/models/praise/praise';

@Injectable()
export class PraiseService {
  private readonly praises: Praise[] = [];

  async postPraise(praise: Omit<Praise, 'id'>): Promise<Praise> {
    const prise = new Praise();
    prise.id = this.praises.length + 1;
    prise.title = praise.title;
    prise.description = praise.description;
    this.praises.push(prise);
    return prise;
  }

  async getCurrentPraise(): Promise<Praise | undefined> {
    return this.praises[this.praises.length - 1];
  }
}
